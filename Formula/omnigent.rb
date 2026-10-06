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
  url "https://files.pythonhosted.org/packages/21/ba/2b9e4320ef064bed499b7cbacfe0476af01ad7bc25917a14af53b0a656d8/omnigent-0.17.0.tar.gz"
  sha256 "20bc4039f4f3d6f59e3179b3a1692ce3ea8c7be36619a437748bf2a06bfa4147"
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
    url "https://files.pythonhosted.org/packages/ed/aa/02910bdb8e2f1444f6654d5b296cd827d126f82209050ee7b1000f92ac4b/alembic-1.20.0.tar.gz"
    sha256 "db505480647bc60386c5369402f4a57a506b7539c9e9ef5e270d45cbbe4939bf"
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
    url "https://files.pythonhosted.org/packages/a9/d2/f4d173e22df740bc37b1db102b386ba719b66e95b0f0d751f556b387e6d2/anyio-4.15.1.tar.gz"
    sha256 "9f28306018cbd6d329e64a36d58256edff76dd996fe423bc957326e578b82a94"
  end
  resource "argon2-cffi" do
    url "https://files.pythonhosted.org/packages/31/fa/57ec2c6d16ecd2ba0cf15f3c7d1c3c2e7b5fcb83555ff56d7ab10888ec8f/argon2_cffi-23.1.0.tar.gz"
    sha256 "879c3e79a2729ce768ebb7d36d4609e3a78a4ca2ec3a9f12286ca057e3d0db08"
  end
  resource "argon2-cffi-bindings" do
    url "https://files.pythonhosted.org/packages/0b/43/bb8b6e8708d49a5ab36781333af092d9f483b198a2710d01281204640055/argon2_cffi_bindings-26.1.0.tar.gz"
    sha256 "63505c71542a44b68b1e38060450fb006404170da375feb31af153e7f9c6205d"
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
    url "https://files.pythonhosted.org/packages/e5/3f/143b048436775b0f76ac3eec145c019e8173ccc2885c8f20319b996d5e83/charset_normalizer-3.5.1.tar.gz"
    sha256 "6117b84ea48435e5356dc737f5121485c30920ba43375fa7b434fd753df0eac3"
  end
  resource "claude-agent-sdk" do
    url "https://files.pythonhosted.org/packages/8b/e1/8c94ff7f200eabcee9a9e57825dfac596bb6fbdeeafa594f49bc7e7f89b5/claude_agent_sdk-0.2.161.tar.gz"
    sha256 "284a1372ec3af133578009ab2b821a238272dbf17d687a58be9df918d7b3ae89"
  end
  resource "click" do
    url "https://files.pythonhosted.org/packages/c7/0e/7fa0ef50764b67090eca4114772a2abf8b6148198475e54c660b97caeee6/click-8.5.0.tar.gz"
    sha256 "ba0d2089de75ea0310e2dde03160e6ca10009947fb95a182f9b54021bb272e34"
  end
  resource "cursor-sdk" do
    url "https://files.pythonhosted.org/packages/14/27/f018b131088f5053bc89f50d22d414fd0f92f418ce465b0de6609bf5d7d1/cursor_sdk-1.0.32.tar.gz"
    sha256 "c02442ff190c804dac0061587d616226721d23bdea2e87592331df368f6f4a88"
  end
  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end
  resource "fastapi" do
    url "https://files.pythonhosted.org/packages/8a/02/91e3416a8fdd715abb903a952a6bec7cdd8d14eed55d415fc8595524c319/fastapi-0.141.1.tar.gz"
    sha256 "e8822fc40db1e1858054d7a949a888695bc9bdce70139178e33bd2871a453ca1"
  end
  resource "filelock" do
    url "https://files.pythonhosted.org/packages/2b/2d/5cb7a5ac017031e96a63173f3d57a8a5162ce36f9ff461e62bc6da4d88ab/filelock-4.0.6.tar.gz"
    sha256 "323fab3b2fb22d889b29fa83774f60029addddb4b6a1bcfa1e73066eabffb5f2"
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
  resource "griffelib" do
    url "https://files.pythonhosted.org/packages/27/af/018c10bc9edd42b6ef6db2e96b09542050d5253f9b195e74bc910b2d13ab/griffelib-2.3.0.tar.gz"
    sha256 "7b0952caf5bca6afa4bb5ee8c6a2d183fe3f21b62efc5f6c7243cb2b26d2d115"
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
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
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
    url "https://files.pythonhosted.org/packages/9c/1f/8176d92e001f86505424b41664032ae26a882bc9ca41a32c803f373f9195/jiter-0.17.0.tar.gz"
    sha256 "03e432f226a453851079fb84cd17c6da9991eab723e28d716f14ae3d906e0c12"
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
    url "https://files.pythonhosted.org/packages/5a/09/e07c4b5579a79f4b16f8d4f29f6c54514ac787c4ad506b8c4f28a0e6b0bf/mako-1.4.3.tar.gz"
    sha256 "cd6537fe88d5fec315c55c2f8529bc4ce7a9a352ad7db3eeaa6a66e2dd4ec37a"
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
    url "https://files.pythonhosted.org/packages/ba/93/0142dc84a666daf8ad51a34268f34c12fd6fda4f3810c4be2504eecc8212/mcp-1.30.0.tar.gz"
    sha256 "445414625fce5c295faa505bb11bacece661ab6f4028d57c935db57820b7a3e4"
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
    url "https://files.pythonhosted.org/packages/49/06/46ede3ee3712ef429519950997a916dd181391e8704c55b5035ffecc7ace/omnigent_client-0.17.0.tar.gz"
    sha256 "5f696f970a77897318c170648e450379ada45d0d543033ae33d5af5c70617df9"
  end
  resource "omnigent-ui-sdk" do
    url "https://files.pythonhosted.org/packages/30/af/e90eb6c103530aecf66e424f1a829b828c475dfc84f9e759022fcf838b94/omnigent_ui_sdk-0.17.0.tar.gz"
    sha256 "95be9fb633ec95469c54e8d884d6fde09c36fb0f83ca606aedebca525f301c5f"
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
    url "https://files.pythonhosted.org/packages/1f/dc/e12c1fe1ed8a7b7149777127b1a0e12ce5bd5a81d97408bedc2128c260f5/opentelemetry_api-1.45.0.tar.gz"
    sha256 "711ede81773c8025c2c03dac0450bc89f3d30aea6eabcc815c570d4e35a963f7"
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
  resource "pillow" do
    on_arm do
      url "https://files.pythonhosted.org/packages/c7/da/32c752228ae345f489e3a42499d817b6c3996da7e8a3bc7a04fc806b243b/pillow-12.3.0-cp314-cp314-macosx_11_0_arm64.whl"
      sha256 "e158cb00350dc278f3b91551101aa7d12415a66ebf2c91d8d5ac14e56ddd3ad0"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/85/e2/73c77d218410b14f5f2d565e8a998d5317b7b9c75368d29985139f7a46f0/pillow-12.3.0-cp314-cp314-macosx_10_15_x86_64.whl"
      sha256 "ba54cfebe86920a559a7c4d6b9050791c20513650a1952ebe3368c7dc70306f8"
    end
  end
  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/7d/ea/39b988c938f75cb75d7045b5c69f8bfed47ee2152c8837fb403de29d6fb8/prompt_toolkit-3.0.53.tar.gz"
    sha256 "9ec8a0ad96d5c56148b3f914aa79c1564c3fde5d2e6b876e7bc327e353cf8fa6"
  end
  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/32/72/98342feb672507c8f3a69e34b4fa8961f608edba5c1a48a6f47156d92cb5/protobuf-7.36.2-cp310-abi3-macosx_10_9_universal2.whl"
    sha256 "cbc70b17ee27e28894c7fee8bb04be1abead49e936bc70eb60052531eee2079e"
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
    url "https://files.pythonhosted.org/packages/68/ca/31c57507b13119d7d3cfa1576dad2911a4861e3be07b579395f4e9d393f9/pydantic_settings-2.15.0.tar.gz"
    sha256 "694b793e84f766ba76a90ebdefc01d0a9a045dab0382bee70393da93712ad117"
  end
  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end
  resource "pyjwt" do
    url "https://files.pythonhosted.org/packages/43/ea/5194e52748b0da83d71e082d75496eaec6e58f419f5e184786ded517e6a9/pyjwt-2.15.1.tar.gz"
    sha256 "4f259e80cdfb6b3fc18a7de51fd1ef9ec79652f25019bae68975ca2468a34df8"
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
    url "https://files.pythonhosted.org/packages/6a/53/ed9d74092561d4b01a2ef1349d52cdbc135e526c245f366b089cfca6de49/python_dotenv-1.2.3.tar.gz"
    sha256 "a20a594dabeaa385725aa239d5244871c143ecb356add8a20fcf23773a6c3a35"
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
    url "https://files.pythonhosted.org/packages/93/1f/d9dc6f02f569625faf67a4daec926cd5023472dcd69bb44286dccd5a5ab3/regex-2026.9.29-cp314-cp314-macosx_10_15_universal2.whl"
    sha256 "957bb708e8057ab1649ba566456429d691ec9b90d1c9ad1af1ba7ffbbeaf05f2"
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
    url "https://files.pythonhosted.org/packages/a8/cb/7c68da82239ffae9378eca076afe14c310e17a4f01e3d315112f266e26c7/sqlalchemy-2.1.1.tar.gz"
    sha256 "fcf3cbb33bb23bad75d2150157c21804618745731e9931ab27e61879a9f6123b"
  end
  resource "sse-starlette" do
    url "https://files.pythonhosted.org/packages/e4/be/0123026f719d1a7936f214a88b553bb5701e04ff2511147c1dab0c5035eb/sse_starlette-3.5.0.tar.gz"
    sha256 "75de713aa8a9441513cc283220826da079d982770965b951e9437720e8bafdb2"
  end
  resource "starlette" do
    url "https://files.pythonhosted.org/packages/7b/2b/3850dc6bf7ef71b088962eba31dafc6cffd2f96e577ebb0bb316df96da3e/starlette-1.7.0.tar.gz"
    sha256 "c79f74ea63cff761804fbbfb182f1e0b440c2d07b164d24700c5a1bab5d6ff5d"
  end
  resource "tiktoken" do
    url "https://files.pythonhosted.org/packages/66/62/167a842aa0429d45f5e797354fd4343a96f6043d67d0513c675c7b8d36e6/tiktoken-0.14.0.tar.gz"
    sha256 "231dec90efcdccf1b565a1416107736f1e09b1a08fe736ef9d6363e626d03874"
  end
  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/94/96/e07752635b98536177fa1f37671c8f3cdde2e724c6bcf6034b2cfb571565/tomlkit-0.15.1.tar.gz"
    sha256 "e25bbf38843005246210a12982776f27f99cb9be67160e14434d0c0d21ee1e97"
  end
  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/0d/ea/b2a5bd54b28a324dae8211928b2d730b6547500342c7e6c6dea08bd0a485/tqdm-4.70.1.tar.gz"
    sha256 "cefd0eca11b2a37a3aee776544d4f4ae913f02688135b5556b8788dfa474afc4"
  end
  resource "types-requests" do
    url "https://files.pythonhosted.org/packages/c0/18/4c2c0290953f8b3b9612adfcb07b57f144ade3ad32a76764fca42b77c5f3/types_requests-2.33.0.20260906.tar.gz"
    sha256 "76ab8a0fb736744a0c3deee7aa57b2927e301f078d9e61f5391b3e92002416b9"
  end
  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end
  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/a3/26/b09b8010994eccc3c09092e6b34058f36a460eea2d4c3e8b910c695975a0/typing_inspection-0.4.4.tar.gz"
    sha256 "547274fa6b0a561ccf549cc9524b999a578e737d015d8709d021f9d0d13bea47"
  end
  resource "tzdata" do
    url "https://files.pythonhosted.org/packages/e4/31/3d74fa778a63b98b7374323befcc0be5ab3bd94afd4096a0124e7379152c/tzdata-2026.4.tar.gz"
    sha256 "f1b8bd365d8d210c55353f4d7f8d6d8561c0ba50d704b700d195a9424bba0d79"
  end
  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e3/05/b17359e1cefb4f909b5e40b1b90a496d987258916dbbf88e842c729f510e/urllib3-2.8.0.tar.gz"
    sha256 "63bf2ead4c879426ebf22ef2a781eeb4aa3b4ae798a0435506f8687fd5bb9b63"
  end
  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/da/34/30e9280707135d2cfc589dfff3cb796bd07a3aeb1a3e415ba09dd89d7bb4/uvicorn-0.54.0.tar.gz"
    sha256 "a2e33cbfaa0306f8e6b0c13e0cb89d7d7a2da3e62b90c66e18c33d9807b28620"
  end
  resource "uvloop" do
    url "https://files.pythonhosted.org/packages/90/cd/b62bdeaa429758aee8de8b00ac0dd26593a9de93d302bff3d21439e9791d/uvloop-0.22.1-cp314-cp314-macosx_10_13_universal2.whl"
    sha256 "3879b88423ec7e97cd4eba2a443aa26ed4e59b45e6b76aabf13fe2f27023a142"
  end
  resource "watchfiles" do
    url "https://files.pythonhosted.org/packages/b3/68/e6aa0b77d217b31f8f486ec0cdfe5e00e6e38dc0be657e7d85819b9faf0a/watchfiles-1.3.0.tar.gz"
    sha256 "99aee4a07847c06820765fd7b1b49ceac4f3f711ccb7d104655a33231de1c207"
  end
  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/dc/ac/3a943d2792c9bb368aaa8b50121c0f778460ba2d7fbdc0a0366201d9e761/wcwidth-0.9.1.tar.gz"
    sha256 "5823209b0d43af322ce698c689380d7c15ca31fa8e6e3be8459f27031bef0af5"
  end
  resource "websockets" do
    url "https://files.pythonhosted.org/packages/94/54/8359678c726243d19fae38ca14a334e740782336c9f19700858c4eb64a1e/websockets-14.2.tar.gz"
    sha256 "5059ed9c54945efb321f097084b4c7e52c246f2c869815876a69d1efc4ad6eb5"
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

    if (cargo_index = ENV.fetch("HOMEBREW_CARGO_INDEX_URL", nil).presence)
      (buildpath/".cargo").mkpath
      (buildpath/".cargo/config.toml").write <<~TOML
        [source.crates-io]
        replace-with = "mirror"

        [source.mirror]
        registry = "sparse+#{cargo_index}"
      TOML
      ENV["CARGO_HOME"] = buildpath/".cargo"
    end

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
