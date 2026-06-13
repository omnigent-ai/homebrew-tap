class Omnigent < Formula
  include Language::Python::Virtualenv

  desc "Meta-harness for AI agents"
  homepage "https://github.com/omnigent-ai/omnigent"
  url "https://github.com/omnigent-ai/omnigent/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3fc803be99fbf461f45cc89c4434fed75212ff0680bc6a8fcae1c1e2eab3dff0"
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
    if build.head?
      # From source: omnigent-client and omnigent-ui-sdk are path dependencies
      # with a circular dependency on omnigent, so all three must be resolved
      # together in one pip invocation. This builds the web UI from source (npm).
      system libexec/"bin/python", "-m", "pip", "install",
             buildpath, buildpath/"sdks/python-client", buildpath/"sdks/ui"
    else
      # Stable: install the published release by name+version. This pulls the
      # prebuilt py3-none-any wheel (web UI bundled) plus its lockstep
      # omnigent-client / omnigent-ui-sdk siblings from PyPI, so nothing builds
      # from source. The tagged tarball above only anchors the version/checksum.
      system libexec/"bin/python", "-m", "pip", "install", "omnigent==#{version}"
    end
    bin.install_symlink libexec/"bin/omnigent", libexec/"bin/omni"

    %w[omnigent omni].each do |cmd|
      generate_completions_from_executable(libexec/"bin/#{cmd}",
                                           base_name: cmd, shell_parameter_format: :click)
    end
  end

  test do
    system bin/"omnigent", "--help"
  end
end
