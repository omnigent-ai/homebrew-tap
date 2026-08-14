# Homebrew formula TEMPLATE for the Omnigent CLI (`omnigent` / `omni`).
#
# The volatile parts of this formula are regenerated on every release by
# `generate_formula.py` (run from `.github/workflows/homebrew-tap-pr.yml`) and
# spliced into this file via three placeholders that live ONLY in the class body
# below — keep them out of this comment or the splicer will mangle it:
#   * the stable `url` / `sha256` lines  -> the released omnigent sdist on PyPI
#   * the per-dependency `resource` stanzas (one per package in the closure: the
#     PyPI sdist, or a pinned wheel for WHEEL_REQUIRED / PREFER_WHEEL)
#
# Edit the hand-tuned STRUCTURAL parts here (desc, depends_on, install, test).
# Edit the dependency set in omnigent-ai/omnigent's `pyproject.toml`
# (`[project.dependencies]` and the bundled `cursor` extra).
# When you change the brewed `depends_on ... => :no_linkage` set, also update the
# `BREWED_EXCLUSIONS` in `generate_formula.py` so those packages are emitted as
# resources (or not) to match.
#
# `bottle do … end` and `revision` are deliberately NOT here: Homebrew's
# `brew pr-pull` adds the bottle block after `brew test-bot` builds it, and
# bumps `revision` on each rebuild. A new version starts at revision 0
# (omitted).
class Omnigent < Formula
  include Language::Python::Virtualenv

  desc "Meta-harness for AI agents"
  homepage "https://github.com/omnigent-ai/omnigent"
  url "https://files.pythonhosted.org/packages/b0/df/2f9f166e6cfc967132acc31f36d2d79684252bdee650c8b8611a5f120d68/omnigent-0.9.0.tar.gz"
  sha256 "a68bcd3d70d98aac83f809d8730cc6ef64136e5d8287dfcebd8673eb682eb265"
  license "Apache-2.0"

  # Most compiled extensions come from upstream wheels (see PREFER_WHEEL in
  # generate_formula.py). jiter, tiktoken and watchfiles still build here, because
  # their maturin wheels have no Mach-O install-name padding and Homebrew cannot
  # relocate them -- hence the Rust toolchain and the RUSTFLAGS below.
  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  # certifi, cryptography, pydantic (which bundles pydantic-core), and rpds-py
  # are provided by Homebrew formulae rather than built as virtualenv resources.
  # The compiled ones would otherwise need a Rust/C build, and their transitive
  # deps (cffi, pycparser) come along for free. The virtualenv is created with
  # system site-packages, so it imports them from the brewed python. :no_linkage
  # because they are Python imports, not libraries this formula links against.
  depends_on "certifi" => :no_linkage
  depends_on "cryptography" => :no_linkage
  depends_on "libyaml"
  depends_on "pydantic" => :no_linkage
  depends_on "python@3.14"
  depends_on "rpds-py" => :no_linkage
  depends_on "tmux"

  resource "alembic" do
    url "https://files.pythonhosted.org/packages/fb/01/a48dab7827ac4421272399f7ed9a2ec17edd12c8bcde4417bd7b6821b71a/alembic-1.19.0.tar.gz"
    sha256 "6487c612fc719dcfa22b17d2dd5b2b458929641e6aa2f0b65b135727f5e6d501"
  end
  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/5a/8e/38aa427ed5402449e226975b649c5dc73ccadfefeb95e6aecb8f8ea4b6b6/annotated_doc-0.0.5.tar.gz"
    sha256 "c7e58ce09192557605d8bbd92836d7e1d520ac9580096042c0bfd197efacf1bb"
  end
  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/5f/56/a8120250d128bed162cd73c76d45f6ef9991f3e068f62a8ee060afa3104a/annotated_types-0.8.0.tar.gz"
    sha256 "13b2beaad985e05e2d6407ee4c4f35590b11f8d693a258a561055cac8f64cab7"
  end
  resource "anyio" do
    url "https://files.pythonhosted.org/packages/61/cc/a381afa6efea9f496eff839d4a6a1aed3bfafc7b3ab4b0d1b243a12573dd/anyio-4.14.2.tar.gz"
    sha256 "cfa139f3ed1a23ee8f88a145ddb5ac7605b8bbfd8592baacd7ce3d8bb4313c7f"
  end
  resource "argon2-cffi" do
    url "https://files.pythonhosted.org/packages/31/fa/57ec2c6d16ecd2ba0cf15f3c7d1c3c2e7b5fcb83555ff56d7ab10888ec8f/argon2_cffi-23.1.0.tar.gz"
    sha256 "879c3e79a2729ce768ebb7d36d4609e3a78a4ca2ec3a9f12286ca057e3d0db08"
  end
  resource "argon2-cffi-bindings" do
    url "https://files.pythonhosted.org/packages/1d/57/96b8b9f93166147826da5f90376e784a10582dd39a393c99bb62cfcf52f0/argon2_cffi_bindings-25.1.0-cp39-abi3-macosx_10_9_universal2.whl"
    sha256 "aecba1723ae35330a008418a91ea6cfcedf6d31e5fbaa056a166462ff066d500"
  end
  resource "asgiref" do
    url "https://files.pythonhosted.org/packages/e6/26/3b59f2bdae5f640389becb1f673cded775287f5fc4f816309d9ca9a3f93d/asgiref-3.12.1.tar.gz"
    sha256 "59dcb51c272ad209d59bed5708a64a333083e86017d7fcdd67498eeab7784340"
  end
  resource "attrs" do
    url "https://files.pythonhosted.org/packages/9a/8e/82a0fe20a541c03148528be8cac2408564a6c9a0cc7e9171802bc1d26985/attrs-26.1.0.tar.gz"
    sha256 "d03ceb89cb322a8fd706d4fb91940737b6642aa36998fe130a9bc96c985eff32"
  end
  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/39/91/d9ae9a66b01102a18cd16db0cf4cd54187ffe10f0865cc80071a4104fbb3/cachetools-6.2.6.tar.gz"
    sha256 "16c33e1f276b9a9c0b49ab5782d901e3ad3de0dd6da9bf9bcd29ac5672f2f9e6"
  end
  resource "cel-python" do
    url "https://files.pythonhosted.org/packages/61/4e/f821948a5bbd7a98a218720f831a62216f79a98e43b13d9ab2f98e37c5f8/cel_python-0.5.0.tar.gz"
    sha256 "3eb0a619e8df0f338d0430cda01427a742e77e3c433a1c7c3ebd409cd804c45a"
  end
  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/bd/2a/23f34ec9d04624958e137efdc394888716353190e75f25dd22c7a2c7a8aa/charset_normalizer-3.4.9.tar.gz"
    sha256 "673611bbd43f0810bec0b0f028ddeaaa501190339cac411f347ac76917c3ae7b"
  end
  resource "claude-agent-sdk" do
    url "https://files.pythonhosted.org/packages/3b/ab/b2144806f4210582a0135734bb5f8ce40fd3ff2e867598b0f3234cc6f865/claude_agent_sdk-0.2.129.tar.gz"
    sha256 "bf2ac3e5f8367a3f5edfb62f74a19ccd0bcd6277c555c8359dd9aa98f7abcf4f"
  end
  resource "click" do
    url "https://files.pythonhosted.org/packages/76/d4/81420972a676e8ffea40450d8c8c92943e7218a78fe9b64359836cc9876b/click-8.4.2.tar.gz"
    sha256 "9a6cea6e60b17ebe0a44c5cc636d94f09bd66142c1cd7d8b4cd731c4917a15f6"
  end
  resource "cursor-sdk" do
    url "https://files.pythonhosted.org/packages/db/7d/15d31f5f2e723c41a2602342ef83e80978847a85bdb5af2722a688b50bf3/cursor_sdk-1.0.26.tar.gz"
    sha256 "cd4bdf0b44bc61b517c78efc11e2a2b3bbb701f06d6b4b1b55107df9572ada04"
  end
  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end
  resource "fastapi" do
    url "https://files.pythonhosted.org/packages/8a/02/91e3416a8fdd715abb903a952a6bec7cdd8d14eed55d415fc8595524c319/fastapi-0.141.1.tar.gz"
    sha256 "e8822fc40db1e1858054d7a949a888695bc9bdce70139178e33bd2871a453ca1"
  end
  resource "ftfy" do
    url "https://files.pythonhosted.org/packages/a5/d3/8650919bc3c7c6e90ee3fa7fd618bf373cbbe55dff043bd67353dbb20cd8/ftfy-6.3.1.tar.gz"
    sha256 "9b3c3d90f84fb267fe64d375a07b7f8912d817cf86009ae134aa03e1819506ec"
  end
  resource "google-re2" do
    on_arm do
      url "https://files.pythonhosted.org/packages/5e/7f/7eb238bdcd06182b5f427afd305cf413b7cf4ea71047308bbf35912cf923/google_re2-1.1.20251105-1-cp314-cp314-macosx_13_0_arm64.whl"
      sha256 "cc151cf6a585d9ebe711da32b23683fcff40f78db8c8587c7f4b209ef4658809"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/6d/62/eed28eab67f939f4b9383c47b1db11638ade6ac30785c15cb960de85ba43/google_re2-1.1.20251105-1-cp314-cp314-macosx_13_0_x86_64.whl"
      sha256 "7e2186d2c90488c1e11895343941f35ca2f58e9ba6c6b034fd531abe22ef77cc"
    end
  end
  resource "googleapis-common-protos" do
    url "https://files.pythonhosted.org/packages/b5/c8/f439cffde755cffa462bfbb156278fa6f9d09119719af9814b858fd4f81f/googleapis_common_protos-1.75.0.tar.gz"
    sha256 "53a062ff3c32552fbd62c11fe23768b78e4ddf0494d5e5fd97d3f4689c75fbbd"
  end
  resource "greenlet" do
    url "https://files.pythonhosted.org/packages/a3/74/b13368064b09053253555d3f2839cc2684d22d5aed0d2ccffbf7a6736558/greenlet-3.5.4.tar.gz"
    sha256 "0232ae1de90a8e07867bb127d7a6ba2301e859145489f25cda8a6096dabe1d20"
  end
  resource "griffelib" do
    url "https://files.pythonhosted.org/packages/33/e4/8d187ea29c2e30b3a09505c567513077d6117861bde1fbd997a167f262ec/griffelib-2.1.0.tar.gz"
    sha256 "762a186d2c6fd6794d4ea20d428d597ffb857cb56b66421651cbba15bdd5e813"
  end
  resource "grpcio" do
    url "https://files.pythonhosted.org/packages/d0/ab/d3874931d123a95e83a3ebf8aa04537988fb62425cedb8bf3cefc5ad41b2/grpcio-1.83.0-cp314-cp314-macosx_11_0_universal2.whl"
    sha256 "d05ff664100d429335b93c91b8b34ddf9e94a112205e7fa06dede309e44a4e4c"
  end
  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end
  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end
  resource "httptools" do
    url "https://files.pythonhosted.org/packages/1a/12/fa3fbf5f9517b273edea2dc982aa82a8c634091e67c590792b729017bc6f/httptools-0.8.0-cp314-cp314-macosx_10_13_universal2.whl"
    sha256 "de242a49b5d18e0a8776e654e9f6bf6d89f3875a5c35b425a0e7ce940feb3fd6"
  end
  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end
  resource "httpx-sse" do
    url "https://files.pythonhosted.org/packages/0f/4c/751061ffa58615a32c31b2d82e8482be8dd4a89154f003147acee90f2be9/httpx_sse-0.4.3.tar.gz"
    sha256 "9b1ed0127459a66014aec3c56bebd93da3c1bc8bb6618c8082039a44889a755d"
  end
  resource "idna" do
    url "https://files.pythonhosted.org/packages/cd/63/9496c57188a2ee585e0f1db071d75089a11e98aa86eb99d9d7618fc1edce/idna-3.18.tar.gz"
    sha256 "ffb385a7e039654cef1ab9ef32c6fafe283c0c0467bba1d9029738ce4a14a848"
  end
  resource "jaraco-classes" do
    url "https://files.pythonhosted.org/packages/06/c0/ed4a27bc5571b99e3cff68f8a9fa5b56ff7df1c2251cc715a652ddd26402/jaraco.classes-3.4.0.tar.gz"
    sha256 "47a024b51d0239c0dd8c8540c6c7f484be3b8fcf0b2d85c13825780d3b3f3acd"
  end
  resource "jaraco-context" do
    url "https://files.pythonhosted.org/packages/af/50/4763cd07e722bb6285316d390a164bc7e479db9d90daa769f22578f698b4/jaraco_context-6.1.2.tar.gz"
    sha256 "f1a6c9d391e661cc5b8d39861ff077a7dc24dc23833ccee564b234b81c82dfe3"
  end
  resource "jaraco-functools" do
    url "https://files.pythonhosted.org/packages/6c/1f/c23395957d41ccf27c4e535c3d334c4051e5395b3752057ba4cbaec35c56/jaraco_functools-4.6.0.tar.gz"
    sha256 "880c577ec9720b3a052d5bc611fb9f2269b3d87902ef42440df443b88e443280"
  end
  resource "jiter" do
    url "https://files.pythonhosted.org/packages/1d/1f/10936e16d8860c70698a1aa939a46aa0224813b782bce4e000e637da0b2d/jiter-0.16.0.tar.gz"
    sha256 "7b24c3492c5f4f84a37946ad9cf504910cf6a782d6a4e0689b6673c5894b4a1c"
  end
  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/d3/59/322338183ecda247fb5d1763a6cbe46eff7222eaeebafd9fa65d4bf5cb11/jmespath-1.1.0.tar.gz"
    sha256 "472c87d80f36026ae83c6ddd0f1d05d4e510134ed462851fd5f754c8c3cbb88d"
  end
  resource "json5" do
    url "https://files.pythonhosted.org/packages/e4/7d/05c46a96a78147ae3bf99c2f4169ce144a70220b8d6fcd56f6ec368b8ce9/json5-0.15.0.tar.gz"
    sha256 "7424d1f1eb1d56da6e3d70643f53619862b4ce81440bdb8ecfd6f875e5ba4a71"
  end
  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/b3/fc/e067678238fa451312d4c62bf6e6cf5ec56375422aee02f9cb5f909b3047/jsonschema-4.26.0.tar.gz"
    sha256 "0c26707e2efad8aa1bfc5b7ce170f3fccc2e4918ff85989ba9ffa9facb2be326"
  end
  resource "jsonschema-specifications" do
    url "https://files.pythonhosted.org/packages/19/74/a633ee74eb36c44aa6d1095e7cc5569bebf04342ee146178e2d36600708b/jsonschema_specifications-2025.9.1.tar.gz"
    sha256 "b540987f239e745613c7a9176f3edb72b832a4ac465cf02712288397832b5e8d"
  end
  resource "keyring" do
    url "https://files.pythonhosted.org/packages/43/4b/674af6ef2f97d56f0ab5153bf0bfa28ccb6c3ed4d1babf4305449668807b/keyring-25.7.0.tar.gz"
    sha256 "fe01bd85eb3f8fb3dd0405defdeac9a5b4f6f0439edbb3149577f244a2e8245b"
  end
  resource "lark" do
    url "https://files.pythonhosted.org/packages/da/34/28fff3ab31ccff1fd4f6c7c7b0ceb2b6968d8ea4950663eadcb5720591a0/lark-1.3.1.tar.gz"
    sha256 "b426a7a6d6d53189d318f2b6236ab5d6429eaf09259f1ca33eb716eed10d2905"
  end
  resource "mako" do
    url "https://files.pythonhosted.org/packages/00/62/791b31e69ae182791ec67f04850f2f062716bbd205483d63a215f3e062d3/mako-1.3.12.tar.gz"
    sha256 "9f778e93289bd410bb35daadeb4fc66d95a746f0b75777b942088b7fd7af550a"
  end
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end
  resource "markupsafe" do
    on_arm do
      url "https://files.pythonhosted.org/packages/b5/64/7660f8a4a8e53c924d0fa05dc3a55c9cee10bbd82b11c5afb27d44b096ce/markupsafe-3.0.3-cp314-cp314-macosx_11_0_arm64.whl"
      sha256 "c47a551199eb8eb2121d4f0f15ae0f923d31350ab9280078d1e5f12b249e0026"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/33/8a/8e42d4838cd89b7dde187011e97fe6c3af66d8c044997d2183fbd6d31352/markupsafe-3.0.3-cp314-cp314-macosx_10_13_x86_64.whl"
      sha256 "eaa9599de571d72e2daf60164784109f19978b327a3910d3e9de8c97b5b70cfe"
    end
  end
  resource "mcp" do
    url "https://files.pythonhosted.org/packages/30/d3/f9acc21dfc886e4f78e2add1a47db46ce16884346afde53f8a064c02c891/mcp-1.29.0.tar.gz"
    sha256 "52d01f334de1868cc3bb2d6604931126a67631f99a6c5d3b82ba47290315ec36"
  end
  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end
  resource "more-itertools" do
    url "https://files.pythonhosted.org/packages/de/1d/f4da6f02cdffe04d6362210b807146a26044c88d839208aec273bb0d9184/more_itertools-11.1.0.tar.gz"
    sha256 "48e8f4d9e7e5878571ecf6f2b4e57634f93cd474cc8cfbd2376f2d11b396e30d"
  end
  resource "omnigent-client" do
    url "https://files.pythonhosted.org/packages/be/fd/cf910ff28ea2e1ce0b66601cdc296a25e4ede539ea1f9469b423e45884d9/omnigent_client-0.9.0.tar.gz"
    sha256 "f317c349ceddb0b53c617ae4c7212414c9176e0c96fbcf3f57ad73758eb43bd4"
  end
  resource "omnigent-ui-sdk" do
    url "https://files.pythonhosted.org/packages/db/37/e813dfabb1f14b1d63962da955ff444fda7c0ab648f91a86d1c9034cceae/omnigent_ui_sdk-0.9.0.tar.gz"
    sha256 "eda17800d3efe24455e5257c1e7ed368f2cd99df32bdc3e178f4925e9b56f743"
  end
  resource "openai" do
    url "https://files.pythonhosted.org/packages/49/f5/7c7cb955305cb41f7f3c5fd7e0e38bf6bbf2658468863d4b7b868a5cb8df/openai-2.44.0.tar.gz"
    sha256 "68a5a5ffad82b8ff7d451c437529fb64f7c3b8123aaf0c021966a882d9e3947d"
  end
  resource "openai-agents" do
    url "https://files.pythonhosted.org/packages/4f/e8/a3bc1a91af9c71d2934f8e2f3eee2954540fa95d47b0e3f155d348d91b38/openai_agents-0.13.6.tar.gz"
    sha256 "de7b3add7933ae704a5ee6e531f650d8aabb3ebaa1631f458ba39684a5ed966e"
  end
  resource "opentelemetry-api" do
    url "https://files.pythonhosted.org/packages/ee/8b/aa9e2d8b8dfa7c946f7dec5d1f8f6ba8eca062f43509a06bdb5ce93d26c0/opentelemetry_api-1.44.0.tar.gz"
    sha256 "67647e5e9566edcf421166fdf022b3537f818635daa852b289e34604dc6fb33a"
  end
  resource "opentelemetry-exporter-otlp-proto-common" do
    url "https://files.pythonhosted.org/packages/61/09/4d717852c1cf3f854b76c7110a5d00883bc3c99288b9b0dbcbeb9e306eb6/opentelemetry_exporter_otlp_proto_common-1.44.0.tar.gz"
    sha256 "dc87a5a5bc58f149a56d1547e4691588fa12994cdc3bc039a694ccb3375862ac"
  end
  resource "opentelemetry-exporter-otlp-proto-grpc" do
    url "https://files.pythonhosted.org/packages/1f/47/80d9e9d468dc5de3af5096f5ccdb065fa4dd1470f74495cc53e59e397f47/opentelemetry_exporter_otlp_proto_grpc-1.44.0.tar.gz"
    sha256 "40d1ae9e03fcc36de3cbac610cc99f35894938bff9cfd90fc4ec68bd85448463"
  end
  resource "opentelemetry-exporter-otlp-proto-http" do
    url "https://files.pythonhosted.org/packages/1a/87/95e2a5aaa795b4e2260d74e16df2d5541deb2ea9de010bcd615f4dee2654/opentelemetry_exporter_otlp_proto_http-1.44.0.tar.gz"
    sha256 "c633d7270ad6b57cd4cfbe8b0007a9e2e7c0cb50bd6c50fe2a7b245f721a09d8"
  end
  resource "opentelemetry-instrumentation" do
    url "https://files.pythonhosted.org/packages/13/91/3c58961cb0360cd60509064734f0be4275383c8681d73c580a40ca83ddce/opentelemetry_instrumentation-0.65b0.tar.gz"
    sha256 "071d9d9eced9bd6460444ec3b0c77229870ed05a881c22c84fdede58e4eed09b"
  end
  resource "opentelemetry-instrumentation-asgi" do
    url "https://files.pythonhosted.org/packages/17/83/8e8e83b7ac285281687c7be2fd305213ccccbb8c0a2dd4fb45a8ccaf12c7/opentelemetry_instrumentation_asgi-0.65b0.tar.gz"
    sha256 "892bca67c56522ffa85a8a83cf934d7b50b3be2132e45cbee705825f0a5ba426"
  end
  resource "opentelemetry-instrumentation-fastapi" do
    url "https://files.pythonhosted.org/packages/30/23/b057f8196d06efdc1b50e3ff11fbc499a7d96b35c87f217eb7885542f4ea/opentelemetry_instrumentation_fastapi-0.65b0.tar.gz"
    sha256 "10a3a95486036230413a58fe4fdf4a83fa6bba46918407e527476994bd92bd97"
  end
  resource "opentelemetry-instrumentation-httpx" do
    url "https://files.pythonhosted.org/packages/61/03/a529140241addd4d0acc73bafbd6f74691651b92fc0ae9b4513cf80f07fa/opentelemetry_instrumentation_httpx-0.65b0.tar.gz"
    sha256 "4627aa9c6bb99bf4462c8b565b0ef6aeb9ffad95c6c92868be1ef7895de112ee"
  end
  resource "opentelemetry-instrumentation-sqlalchemy" do
    url "https://files.pythonhosted.org/packages/ae/9d/72af21527ce6f286ac78dc2c75ce44b76cc45343a28f0bcbb13f213421fc/opentelemetry_instrumentation_sqlalchemy-0.65b0.tar.gz"
    sha256 "8ec2e79f1e00808c5dc639ab5b2cfcdf9dcdef55efd6442c6019707fe2894028"
  end
  resource "opentelemetry-proto" do
    url "https://files.pythonhosted.org/packages/64/01/40ac4ae9a149263cc52c2cee200ddd80cb6d8db1a4610abf8eabce0fe771/opentelemetry_proto-1.44.0.tar.gz"
    sha256 "c547a79c2f8c0c515d31509154682e5921c7cfd5ca67b70e1f9266e2c3e103f3"
  end
  resource "opentelemetry-sdk" do
    url "https://files.pythonhosted.org/packages/5d/77/a6592cbc7c8d9bcc9d6757a9df45e04a7c585e3e6e7a13456da522b21109/opentelemetry_sdk-1.44.0.tar.gz"
    sha256 "cebe7f65dc12f26ead75c6064de12fd2a9052e5060c0272d402cfa203aae123b"
  end
  resource "opentelemetry-semantic-conventions" do
    url "https://files.pythonhosted.org/packages/8f/73/0cbdebcb4cf545fdd328da14f5137e37d0770c3f26185e478b0d15d94f50/opentelemetry_semantic_conventions-0.65b0.tar.gz"
    sha256 "f9b2b81e9d5b64f11bc952075e7e9c7fb0aab075c7fd1c46d597f1b919852d60"
  end
  resource "opentelemetry-util-http" do
    url "https://files.pythonhosted.org/packages/32/a9/d7525a59fdd240e69b5af4a6338e78fafa1b4203394122cbd6701fb5f84a/opentelemetry_util_http-0.65b0.tar.gz"
    sha256 "84f82d826978bba416ab453460ff6a7391cdc3534c93a786595e4068680016b7"
  end
  resource "packaging" do
    url "https://files.pythonhosted.org/packages/a1/d4/1fc4078c65507b51b96ca8f8c3ba19e6a61c8253c72794544580a7b6c24d/packaging-25.0.tar.gz"
    sha256 "d443872c98d677bf60f6a1f2f8c1cb748e8fe762d2bf9d3148b5599295b0fc4f"
  end
  resource "pendulum" do
    url "https://files.pythonhosted.org/packages/02/fb/d65db067a67df7252f18b0cb7420dda84078b9e8bfb375215469c14a50be/pendulum-3.2.0-py3-none-any.whl"
    sha256 "f3a9c18a89b4d9ef39c5fa6a78722aaff8d5be2597c129a3b16b9f40a561acf3"
  end
  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/42/92/cc564bf6381ff43ce1f4d06852fc19a2f11d180f23dc32d9588bee2f149d/pexpect-4.9.0.tar.gz"
    sha256 "ee7d41123f3c9911050ea2c2dac107568dc43b2d3b0c7557a33212c398ead30f"
  end
  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/7d/ea/39b988c938f75cb75d7045b5c69f8bfed47ee2152c8837fb403de29d6fb8/prompt_toolkit-3.0.53.tar.gz"
    sha256 "9ec8a0ad96d5c56148b3f914aa79c1564c3fde5d2e6b876e7bc327e353cf8fa6"
  end
  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/5c/01/a3c3ed5cd186f39e7880f8303cc51385a198a81469d53d0fdecf1f64d929/protobuf-6.33.6-cp39-abi3-macosx_10_9_universal2.whl"
    sha256 "9720e6961b251bde64edfdab7d500725a2af5280f3f4c87e57c0208376aa8c3a"
  end
  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end
  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e/ptyprocess-0.7.0.tar.gz"
    sha256 "5c5d0a3b48ceee0b48485e0c26037c0acd7d29765ca3fbb5cb3831d347423220"
  end
  resource "pydantic-settings" do
    url "https://files.pythonhosted.org/packages/5c/b5/8f48e906c3e0205276e8bd8cb7512217a87b2685304d64be27cad5b3019f/pydantic_settings-2.14.2.tar.gz"
    sha256 "c19dd64b19097f1de80184f0cc7b0272a13ae6e170cbf240a3e27e381ed14a5f"
  end
  resource "pygments" do
    url "https://files.pythonhosted.org/packages/c3/b2/bc9c9196916376152d655522fdcebac55e66de6603a76a02bca1b6414f6c/pygments-2.20.0.tar.gz"
    sha256 "6757cd03768053ff99f3039c1a36d6c0aa0b263438fcab17520b30a303a82b5f"
  end
  resource "pyjwt" do
    url "https://files.pythonhosted.org/packages/3b/81/58d0ac84e1ef3a3843791d6954d94c0b33d526c75eeb1efbce9d0a4c4077/pyjwt-2.13.0.tar.gz"
    sha256 "41571c89ca91598c79e8ef18a2d07367d4810fbbd6f637794879baf1b7703423"
  end
  resource "pyte" do
    url "https://files.pythonhosted.org/packages/ab/ab/b599762933eba04de7dc5b31ae083112a6c9a9db15b01d3109ad797559d9/pyte-0.8.2.tar.gz"
    sha256 "5af970e843fa96a97149d64e170c984721f20e52227a2f57f0a54207f08f083f"
  end
  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end
  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/82/ed/0301aeeac3e5353ef3d94b6ec08bbcabd04a72018415dcb29e588514bba8/python_dotenv-1.2.2.tar.gz"
    sha256 "2c371a91fbd7ba082c2c1dc1f8bf89ca22564a087c2c287cd9b662adde799cf3"
  end
  resource "python-multipart" do
    url "https://files.pythonhosted.org/packages/5b/42/55c32bb9b12693c092ad250a0e82edb5b31ddeda6eb772de5f308b3804ad/python_multipart-0.0.32.tar.gz"
    sha256 "be54b7f3fa167bb83e4fcd936b887b708f4e57fe75911c02aebf53efaf8d938e"
  end
  resource "pyyaml" do
    on_arm do
      url "https://files.pythonhosted.org/packages/bd/9c/4d95bb87eb2063d20db7b60faa3840c1b18025517ae857371c4dd55a6b3a/pyyaml-6.0.3-cp314-cp314-macosx_11_0_arm64.whl"
      sha256 "34d5fcd24b8445fadc33f9cf348c1047101756fd760b4dacb5c3e99755703310"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/9d/8c/f4bd7f6465179953d3ac9bc44ac1a8a3e6122cf8ada906b4f96c60172d43/pyyaml-6.0.3-cp314-cp314-macosx_10_13_x86_64.whl"
      sha256 "8d1fab6bb153a416f9aeb4b8763bc0f22a5586065f86f7664fc23339fc1c1fac"
    end
  end
  resource "referencing" do
    url "https://files.pythonhosted.org/packages/22/f5/df4e9027acead3ecc63e50fe1e36aca1523e1719559c499951bb4b53188f/referencing-0.37.0.tar.gz"
    sha256 "44aefc3142c5b842538163acb373e24cce6632bd54bdb01b21ad5863489f50d8"
  end
  resource "regex" do
    url "https://files.pythonhosted.org/packages/d2/25/0c4c452f8ef3efe456745b2f33195f5904b573fb4c2ff3f0cb9ec188461e/regex-2026.7.19-cp314-cp314-macosx_10_13_universal2.whl"
    sha256 "a81758ed242b861b72e778ba34d41366441a2e10b16b472784c88da2dea7e2dd"
  end
  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end
  resource "rich" do
    url "https://files.pythonhosted.org/packages/e9/67/cae617f1351490c25a4b8ac3b8b63a4dda609295d8222bad12242dfdc629/rich-14.3.4.tar.gz"
    sha256 "817e02727f2b25b40ef56f5aa2217f400c8489f79ca8f46ea2b70dd5e14558a9"
  end
  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end
  resource "sniffio" do
    url "https://files.pythonhosted.org/packages/a2/87/a6771e1546d97e7e041b6ae58d80074f81b7d5121207425c964ddf5cfdbd/sniffio-1.3.1.tar.gz"
    sha256 "f4324edc670a0f49750a81b895f35c3adb843cca46f0530f79fc1babb23789dc"
  end
  resource "sqlalchemy" do
    url "https://files.pythonhosted.org/packages/02/f1/a7a892f18d4d224e6b26f706531eafccc41e37594d37d304786969ee13cb/sqlalchemy-2.0.51.tar.gz"
    sha256 "804dccd8a4a6242c4e30ad961e540e18a588f6527202f2d6791b01845d59fdc9"
  end
  resource "sse-starlette" do
    url "https://files.pythonhosted.org/packages/6c/10/a34c656829ffc1c4b22ef36d70d9ebb6b99c020e2aeb17cee5485099f028/sse_starlette-3.4.6.tar.gz"
    sha256 "725f8a1bd6d26ae1b2c9610c0ef5065dfdd496f3988d28adcf8c4b49dc25c627"
  end
  resource "starlette" do
    url "https://files.pythonhosted.org/packages/eb/e3/7c1dc7381d9f8ab7d854328ebfa884e62cb3f3d8549ddfd37c7814f42afa/starlette-1.3.1.tar.gz"
    sha256 "05d0213193f2fbaae60e2ecb593b4add4262ad4e46536b54abe36f11a71724e0"
  end
  resource "tiktoken" do
    url "https://files.pythonhosted.org/packages/e4/e5/5f3cb2159769d0f4324c0e9e87f9de3c4b1cd45848a96b2eb3566ad5ca77/tiktoken-0.13.0.tar.gz"
    sha256 "c9435714c3a84c2319499de9a300c0e604449dd0799ff246458b3bb6a7f433c1"
  end
  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/94/96/e07752635b98536177fa1f37671c8f3cdde2e724c6bcf6034b2cfb571565/tomlkit-0.15.1.tar.gz"
    sha256 "e25bbf38843005246210a12982776f27f99cb9be67160e14434d0c0d21ee1e97"
  end
  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/21/3b/6c24bec5be5e743ffd99576daa5cc077722fc7d5bbc00bd133fa0c698dc6/tqdm-4.70.0.tar.gz"
    sha256 "55b0b0dbd97462d06ebee91e4dac24ed4d4702be82b24f07e6c1d27e08cea220"
  end
  resource "types-requests" do
    url "https://files.pythonhosted.org/packages/db/51/703318f7b7be8bee126ec13bf615050f932d0179b8784420f3a0199cc769/types_requests-2.33.0.20260712.tar.gz"
    sha256 "2141b67ab534a5c5cd2dac5034f2a35f42e699c5bf185eee608c5246a069d7fb"
  end
  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end
  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/55/e3/70399cb7dd41c10ac53367ae42139cf4b1ca5f36bb3dc6c9d33acdb43655/typing_inspection-0.4.2.tar.gz"
    sha256 "ba561c48a67c5958007083d386c3295464928b01faa735ab8547c5692e87f464"
  end
  resource "tzdata" do
    url "https://files.pythonhosted.org/packages/92/ff/5a28bdfd8c3ebec42564ac7d0e54ca3db65044a9314a97f9564fa7a1e926/tzdata-2026.3.tar.gz"
    sha256 "4a1518b8993086a7982523e071643f3c0e5f213e75b21318e78bcabfff9d1415"
  end
  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/53/0c/06f8b233b8fd13b9e5ee11424ef85419ba0d8ba0b3138bf360be2ff56953/urllib3-2.7.0.tar.gz"
    sha256 "231e0ec3b63ceb14667c67be60f2f2c40a518cb38b03af60abc813da26505f4c"
  end
  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/03/18/ccce41535dee1be77735592bd19965f3972c82e07ee703d324709496b716/uvicorn-0.52.1.tar.gz"
    sha256 "112ec661814189acbccd3f7b86460147cc065fc92c0821afa78918780e4354dd"
  end
  resource "uvloop" do
    url "https://files.pythonhosted.org/packages/90/cd/b62bdeaa429758aee8de8b00ac0dd26593a9de93d302bff3d21439e9791d/uvloop-0.22.1-cp314-cp314-macosx_10_13_universal2.whl"
    sha256 "3879b88423ec7e97cd4eba2a443aa26ed4e59b45e6b76aabf13fe2f27023a142"
  end
  resource "watchfiles" do
    url "https://files.pythonhosted.org/packages/cd/41/5e1a4bb12aac5f1493fa1bdc11154eca3b258ca4eba65d39c473fe19d8e9/watchfiles-1.2.0.tar.gz"
    sha256 "c995fba777f1ea992f090f9236e9284cf7a5d1a0130dd5a3d82c598cacd76838"
  end
  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/34/74/c6428f875774288bec1396f5bfcbc2d925700a4dad61727fd5f2b12f249d/wcwidth-0.8.2.tar.gz"
    sha256 "91fbef97204b96a3d4d421609b80340b760cf33e26da123ff243d76b1fda8dda"
  end
  resource "websockets" do
    url "https://files.pythonhosted.org/packages/94/54/8359678c726243d19fae38ca14a334e740782336c9f19700858c4eb64a1e/websockets-14.2.tar.gz"
    sha256 "5059ed9c54945efb321f097084b4c7e52c246f2c869815876a69d1efc4ad6eb5"
  end
  resource "wrapt" do
    url "https://files.pythonhosted.org/packages/2b/b0/c1f5a970721f06b85c0cd5142e0ff8fe067708abd779b0c4f4be7d61d09f/wrapt-2.3.0.tar.gz"
    sha256 "681a2d0eefd721998f90642762b8e75c2159ec531b20ad5e437245ea7b06a107"
  end
  resource "zstandard" do
    on_arm do
      url "https://files.pythonhosted.org/packages/8d/09/d0a2a14fc3439c5f874042dca72a79c70a532090b7ba0003be73fee37ae2/zstandard-0.25.0-cp314-cp314-macosx_11_0_arm64.whl"
      sha256 "05df5136bc5a011f33cd25bc9f506e7426c0c9b3f9954f056831ce68f3b6689f"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/3d/5c/f8923b595b55fe49e30612987ad8bf053aef555c14f05bb659dd5dbe3e8a/zstandard-0.25.0-cp314-cp314-macosx_10_13_x86_64.whl"
      sha256 "e29f0cf06974c899b2c188ef7f783607dbef36da4c242eb6c82dcd8b512855e3"
    end
  end

  def install
    # Homebrew honours HOMEBREW_PIP_INDEX_URL only when downloading the resource
    # archives themselves. Building an sdist then shells out to a second, isolated
    # pip that resolves the build backend (`setuptools`, ...) from *its own* index,
    # which defaults to https://pypi.org/simple. `brew` re-execs through `env -i`
    # with an allowlist and builds run with a scrubbed HOME, so neither a
    # PIP_INDEX_URL export nor ~/.config/pip/pip.conf reaches that child. Forward
    # the mirror explicitly, or every sdist resource fails to build its wheel
    # wherever pypi.org itself is unreachable.
    if Homebrew::EnvConfig.non_default_variable?(:HOMEBREW_PIP_INDEX_URL) &&
       (pip_index_url = Homebrew::EnvConfig.pip_index_url.presence)
      ENV["PIP_INDEX_URL"] = pip_index_url
    end

    venv = virtualenv_create(libexec, "python3.14")

    # jiter, tiktoken and watchfiles are the only Rust builds left. Their
    # extensions must leave Mach-O header padding so Homebrew can rewrite install
    # names to the Cellar path during relocation (macOS only; the flag breaks
    # Linux ld). Everything else compiled is a prebuilt wheel.
    ENV.append_to_rustflags "-C link-args=-Wl,-headerpad_max_install_names" if OS.mac?

    # Pure-Python resources are sdists Homebrew builds in place. Every other
    # compiled extension is pinned to an upstream wheel (WHEEL_REQUIRED /
    # PREFER_WHEEL in generate_formula.py), which is what keeps this formula out of
    # cc/rustc on a 3-core bottle builder. Homebrew only auto-installs
    # `py3-none-any` wheels, so copy each platform wheel's cached download back to
    # its real filename and pip-install the file directly.
    wheels, sdists = resources.partition { |r| r.url.end_with?(".whl") }
    venv.pip_install sdists
    wheels.each do |r|
      whl = buildpath/r.url.split("/").last
      cp r.cached_download, whl
      venv.pip_install whl
    end

    venv.pip_install_and_link buildpath

    bin.install_symlink libexec/"bin/omnigent", libexec/"bin/omni"

    %w[omnigent omni].each do |cmd|
      generate_completions_from_executable(libexec/"bin/#{cmd}",
                                           base_name: cmd, shell_parameter_format: :click)
    end
  end

  test do
    system bin/"omnigent", "--help"

    # certifi, cryptography, pydantic (with pydantic-core), and rpds-py are
    # provided by Homebrew formulae and imported from the brewed python through
    # the virtualenv's system site-packages; confirm they resolve in the venv.
    system libexec/"bin/python", "-c", "import certifi, cryptography, pydantic, rpds"

    # celpy imports re2 at module scope and omnigent imports celpy behind a
    # try/except, so a google-re2 that failed to build disables inline policies
    # silently instead of failing. Import both so the gap is caught at build time.
    system libexec/"bin/python", "-c", "import re2, celpy"
  end
end
