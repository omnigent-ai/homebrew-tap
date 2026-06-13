class Omnigent < Formula
  include Language::Python::Virtualenv

  desc "Meta-harness for AI agents"
  homepage "https://github.com/omnigent-ai/omnigent"
  url "https://github.com/omnigent-ai/omnigent/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3fc803be99fbf461f45cc89c4434fed75212ff0680bc6a8fcae1c1e2eab3dff0"
  license "Apache-2.0"
  head "https://github.com/omnigent-ai/omnigent.git", branch: "main"

  depends_on "python@3.13"
  # Runtime only: the Claude/Codex/Pi coding harnesses are npm CLIs and their
  # terminal launchers use tmux. Neither is needed to install (the published
  # wheel ships the prebuilt web UI) or to run the bare web UI / the in-process
  # claude-sdk / openai-agents harnesses.
  depends_on "node"
  depends_on "tmux"

  # Resolve the published wheels from PyPI at build time rather than vendoring
  # every dependency as a resource. The omnigent wheel bundles the prebuilt
  # web UI, so installing it runs no Node/npm build.
  allow_network_access! :build

  def install
    # The sandboxed build cannot read ~/.config/pip; environments that need a
    # registry mirror set it via HOMEBREW_PIP_INDEX_URL.
    if (index_url = Homebrew::EnvConfig.pip_index_url)
      ENV["PIP_INDEX_URL"] = index_url
    end

    virtualenv_create(libexec, "python3.13")
    # Install the published release by name+version, NOT the checked-out source
    # tree: this pulls the prebuilt py3-none-any wheel (web UI bundled) plus its
    # lockstep omnigent-client / omnigent-ui-sdk siblings from PyPI, so nothing
    # builds from source. The tagged tarball above only anchors the formula
    # version and checksum.
    system libexec/"bin/pip", "install", "omnigent==#{version}"

    # `omnigent` is the primary command; `omni` is a short alias.
    bin.install_symlink libexec/"bin/omnigent"
    bin.install_symlink libexec/"bin/omni"

    %w[omnigent omni].each do |cmd|
      generate_completions_from_executable(libexec/"bin/#{cmd}",
                                           base_name: cmd, shell_parameter_format: :click)
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omnigent --version")
  end
end
