class Omnigent < Formula
  include Language::Python::Virtualenv

  desc "Meta-harness for AI agents"
  homepage "https://github.com/omnigent-ai/omnigent"
  license "Apache-2.0"
  head "https://github.com/omnigent-ai/omnigent.git", branch: "main"

  depends_on "node"
  depends_on "python@3.13"
  depends_on "tmux"

  # Dependencies are resolved from PyPI at build time instead of being
  # vendored as resources.
  allow_network_access! :build

  def install
    # The sandboxed build cannot read ~/.pip/pip.conf or ~/.npmrc, so
    # environments that require registry mirrors must set
    # HOMEBREW_PIP_INDEX_URL and HOMEBREW_NPM_REGISTRY.
    if (index_url = Homebrew::EnvConfig.pip_index_url)
      ENV["PIP_INDEX_URL"] = index_url
    end
    if (npm_registry = ENV.fetch("HOMEBREW_NPM_REGISTRY", nil))
      ENV["npm_config_registry"] = npm_registry
    end

    virtualenv_create(libexec, "python3.13")
    # omnigents-client and omnigents-ui-sdk are uv path dependencies with no
    # PyPI releases and a circular dependency on omnigents, so all three
    # must be resolved together in a single pip invocation.
    system libexec/"bin/python", "-m", "pip", "install",
           buildpath, buildpath/"sdks/python-client", buildpath/"sdks/ui"
    bin.install_symlink libexec/"bin/omnigent", libexec/"bin/omni"

    %w[omnigents omni].each do |cmd|
      generate_completions_from_executable(libexec/"bin/#{cmd}",
                                           base_name: cmd, shell_parameter_format: :click)
    end
  end

  test do
    system bin/"omnigent", "--help"
  end
end
