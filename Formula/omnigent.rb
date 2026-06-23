class Omnigent < Formula
  include Language::Python::Virtualenv

  desc "Meta-harness for AI agents"
  homepage "https://github.com/omnigent-ai/omnigent"
  url "https://files.pythonhosted.org/packages/0d/8e/0ac178a3747da1b888c0bf57bfecf85ab93075331936c659fef4d88cd079/omnigent-0.2.0.tar.gz"
  sha256 "c7638d1f8c7e2f75967a343520a090a87abfe76e42d02c606985e98ea5f5f2f6"
  license "Apache-2.0"
  revision 3

  bottle do
    root_url "https://github.com/omnigent-ai/homebrew-tap/releases/download/omnigent-0.2.0_3"
  end

  # The Rust toolchain builds jiter and watchfiles from source.
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
  # Platform-specific resources:
  # - google-antigravity (antigravity extra) ships platform wheels but no sdist and
  #   no Intel-macOS build, so it is declared only where upstream supports it.
  on_macos do
    on_arm do
      resource "google-antigravity" do
        url "https://files.pythonhosted.org/packages/89/e2/1c6f9d4ffb4d97088cac763fa0dd3604504283f4b8d3ea0c07ca33d9f1ee/google_antigravity-0.1.4-py3-none-macosx_11_0_arm64.whl"
        sha256 "cb83022853d1021abffb103dec248cdff92fe0c6d0121f0229616f5524624d01"
      end
    end
  end
  on_linux do
    on_arm do
      resource "google-antigravity" do
        url "https://files.pythonhosted.org/packages/f7/06/6d853664783e2b17ef2e95a6202add07a331e1dd55430341db257200c251/google_antigravity-0.1.4-py3-none-manylinux_2_17_aarch64.whl"
        sha256 "4276600a2480cb24bf74f3334f082df2059019236766ea23b5af9f9e0e2a4ae0"
      end
    end
    on_intel do
      resource "google-antigravity" do
        url "https://files.pythonhosted.org/packages/5f/72/6efc89b3aa36f85f583afa9b8214f3b758ec6cd056be5798c80f58861826/google_antigravity-0.1.4-py3-none-manylinux_2_17_x86_64.whl"
        sha256 "cbc35edfff18a6795f46c096f8daf2a87653b1739ef4c63b01a04ba795223f95"
      end
    end
  end

  resource "absl-py" do
    url "https://files.pythonhosted.org/packages/64/c7/8de93764ad66968d19329a7e0c147a2bb3c7054c554d4a119111b8f9440f/absl_py-2.4.0.tar.gz"
    sha256 "8c6af82722b35cf71e0f4d1d47dcaebfff286e27110a99fc359349b247dfb5d4"
  end

  resource "alembic" do
    url "https://files.pythonhosted.org/packages/94/13/8b084e0f2efb0275a1d534838844926f798bd766566b1375174e2448cd31/alembic-1.18.4.tar.gz"
    sha256 "cb6e1fd84b6174ab8dbb2329f86d631ba9559dd78df550b57804d607672cedbc"
  end

  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/57/ba/046ceea27344560984e26a590f90bc7f4a75b06701f653222458922b558c/annotated_doc-0.0.4.tar.gz"
    sha256 "fbcda96e87e9c92ad167c2e53839e57503ecfda18804ea28102353485033faa4"
  end

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/1c/b5/001890774a9552aff22502b8da382593109ce0c95314abaebbb116567545/anyio-4.14.0.tar.gz"
    sha256 "b47c1f9ccf73e67021df785332508f99379c68fa7d0684e8e3492cb1d4b23f89"
  end

  resource "argon2-cffi" do
    url "https://files.pythonhosted.org/packages/31/fa/57ec2c6d16ecd2ba0cf15f3c7d1c3c2e7b5fcb83555ff56d7ab10888ec8f/argon2_cffi-23.1.0.tar.gz"
    sha256 "879c3e79a2729ce768ebb7d36d4609e3a78a4ca2ec3a9f12286ca057e3d0db08"
  end

  resource "argon2-cffi-bindings" do
    url "https://files.pythonhosted.org/packages/5c/2d/db8af0df73c1cf454f71b2bbe5e356b8c1f8041c979f505b3d3186e520a9/argon2_cffi_bindings-25.1.0.tar.gz"
    sha256 "b957f3e6ea4d55d820e40ff76f450952807013d361a65d7f28acc0acbf29229d"
  end

  resource "asgiref" do
    url "https://files.pythonhosted.org/packages/63/40/f03da1264ae8f7cfdbf9146542e5e7e8100a4c66ab48e791df9a03d3f6c0/asgiref-3.11.1.tar.gz"
    sha256 "5f184dc43b7e763efe848065441eac62229c9f7b0475f41f80e207a114eda4ce"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/9a/8e/82a0fe20a541c03148528be8cac2408564a6c9a0cc7e9171802bc1d26985/attrs-26.1.0.tar.gz"
    sha256 "d03ceb89cb322a8fd706d4fb91940737b6642aa36998fe130a9bc96c985eff32"
  end

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/39/91/d9ae9a66b01102a18cd16db0cf4cd54187ffe10f0865cc80071a4104fbb3/cachetools-6.2.6.tar.gz"
    sha256 "16c33e1f276b9a9c0b49ab5782d901e3ad3de0dd6da9bf9bcd29ac5672f2f9e6"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e7/a1/67fe25fac3c7642725500a3f6cfe5821ad557c3abb11c9d20d12c7008d3e/charset_normalizer-3.4.7.tar.gz"
    sha256 "ae89db9e5f98a11a4bf50407d4363e7b09b31e55bc117b4f7d80aab97ba009e5"
  end

  resource "claude-agent-sdk" do
    url "https://files.pythonhosted.org/packages/69/73/f5edec88b9548c3757e429dbfc62b16e46cac1300c9463cbb83ed5281266/claude_agent_sdk-0.2.106.tar.gz"
    sha256 "26c20cf75db1ed609aae6217cb6dd40844365c66acf3a7abf4e877671695228e"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/b9/2e/0090cbf739cee7d23781ad4b89a9894a41538e4fcf4c31dcdd705b78eb8b/click-8.1.8.tar.gz"
    sha256 "ed53c9d8990d83c2a27deae68e4ee337473f6330c040a31d4225c9574d16096a"
  end

  resource "cursor-sdk" do
    url "https://files.pythonhosted.org/packages/d6/23/22aa3ef2f4eef082b145fe1d151e28f23f0d93f0f33051106584d1812e67/cursor_sdk-0.1.8.tar.gz"
    sha256 "4e3ab986f3cbf9d98e7013a8a30299c077ff423b58c772a40be10222e1b3b898"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end

  resource "fastapi" do
    url "https://files.pythonhosted.org/packages/5b/58/ff455d9fe47c60abadb34b9e05a304b1f05f5ab8000ac01565156b6f5e43/fastapi-0.138.0.tar.gz"
    sha256 "d445a4877636ad191e7053e08c9bf98cb921a6756776848400bb773d1740c061"
  end

  resource "ftfy" do
    url "https://files.pythonhosted.org/packages/a5/d3/8650919bc3c7c6e90ee3fa7fd618bf373cbbe55dff043bd67353dbb20cd8/ftfy-6.3.1.tar.gz"
    sha256 "9b3c3d90f84fb267fe64d375a07b7f8912d817cf86009ae134aa03e1819506ec"
  end

  resource "google-auth" do
    url "https://files.pythonhosted.org/packages/81/1c/70b23fc52b2bb3c70b379f3bd05c4a60ab3a873e30c6bd21c57e0154848a/google_auth-2.55.0.tar.gz"
    sha256 "fcd3a130f575fa36403d38774af1c64a4fbfbca09215f0589d2372b5119697cb"
  end

  resource "google-genai" do
    url "https://files.pythonhosted.org/packages/51/75/81c01294db3a3005dc8a807ed889a10ecd66ef89462c118adcffa5f7981c/google_genai-2.9.0.tar.gz"
    sha256 "a8a10e9113f460cc668c1d9deeb62ba393ad1ba704bf3166d5a0f32a434f9415"
  end

  resource "googleapis-common-protos" do
    url "https://files.pythonhosted.org/packages/b5/c8/f439cffde755cffa462bfbb156278fa6f9d09119719af9814b858fd4f81f/googleapis_common_protos-1.75.0.tar.gz"
    sha256 "53a062ff3c32552fbd62c11fe23768b78e4ddf0494d5e5fd97d3f4689c75fbbd"
  end

  resource "griffelib" do
    url "https://files.pythonhosted.org/packages/33/e4/8d187ea29c2e30b3a09505c567513077d6117861bde1fbd997a167f262ec/griffelib-2.1.0.tar.gz"
    sha256 "762a186d2c6fd6794d4ea20d428d597ffb857cb56b66421651cbba15bdd5e813"
  end

  resource "grpcio" do
    url "https://files.pythonhosted.org/packages/b0/b5/1ff353970a87eda4c98251e34d2dfd214abd4982dc89119c9252a2a482d2/grpcio-1.81.1.tar.gz"
    sha256 "6fa10a767143a5e82e8eaab53918af0cd8909a57a27f8cb2288b80a613ac671b"
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
    url "https://files.pythonhosted.org/packages/43/e5/d471fcb0e14523fe1c3f4ba58ca52480e7bd70ad7109a3846bc75892f7fb/httptools-0.8.0.tar.gz"
    sha256 "6b2a32f18d97e16e90827d7a819ffa8dbd8cc245fc4e1fa9d1095b54ef4bd999"
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
    url "https://files.pythonhosted.org/packages/36/cf/ea4ef2920830dea3f5ab2ea4da6fb67724e6dca80ee2553788c3607243d0/jaraco_functools-4.5.0.tar.gz"
    sha256 "3bb5665ea4a020cf78a7040e89154c77edadb3ca74f366479669c5999aa70b03"
  end

  resource "jiter" do
    url "https://files.pythonhosted.org/packages/66/b5/55f06bb281d92fb3cc86d14e1def2bd908bb77693183e7cb1f5a3c388b0c/jiter-0.15.0.tar.gz"
    sha256 "4251acc80e2b7c9b7b8823456ea0fceeb0734dac2df7636d3c711b38476b5a76"
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

  resource "mako" do
    url "https://files.pythonhosted.org/packages/00/62/791b31e69ae182791ec67f04850f2f062716bbd205483d63a215f3e062d3/mako-1.3.12.tar.gz"
    sha256 "9f778e93289bd410bb35daadeb4fc66d95a746f0b75777b942088b7fd7af550a"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7/markupsafe-3.0.3.tar.gz"
    sha256 "722695808f4b6457b320fdc131280796bdceb04ab50fe1795cd540799ebe1698"
  end

  resource "mcp" do
    url "https://files.pythonhosted.org/packages/c1/ee/94c6c50ffc5b5cf4737052275d11b57367f32d1a8516e31dcd60591b3916/mcp-1.28.0.tar.gz"
    sha256 "559d3f9943674cafbe5744c5d3794f3237e8b47f9bbc58e20c0fad680d8487c2"
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
    url "https://files.pythonhosted.org/packages/f4/ab/895be231dd207081cddfa8149a2178bb6b5978208193d86814cbb31afd5c/omnigent_client-0.2.0.tar.gz"
    sha256 "7f26f5dd995615147c144c61345c4edceddeccaf13c8181f3c8394f1363902bc"
  end

  resource "omnigent-ui-sdk" do
    url "https://files.pythonhosted.org/packages/47/40/997a3204bac20ad5d40050d90d6ea15f6163f055841fc3686ab25599e25f/omnigent_ui_sdk-0.2.0.tar.gz"
    sha256 "e3ffe9c3150d73f4a8a5375ce86c8eea1b2ffbcd59e48ac36a6beb66b6b97ea6"
  end

  resource "openai" do
    url "https://files.pythonhosted.org/packages/f3/fa/88d0c58a0c58df7e6758e66b99c5d028d5e0bb49f8812d7203940cd9dbf1/openai-2.43.0.tar.gz"
    sha256 "e74d238200a26868977002190fb6631613480a93dfe0c9c982e77021ed60a017"
  end

  resource "openai-agents" do
    url "https://files.pythonhosted.org/packages/fb/90/724f368d1f0656dc750a0b6d3ba06ad88efb293be8d43b08e9d32956252b/openai_agents-0.17.6.tar.gz"
    sha256 "fed94f8cf0eb4c57c63a89ad4b107932d75f2a0b6d9e895c88fa3c217e63c822"
  end

  resource "opentelemetry-api" do
    url "https://files.pythonhosted.org/packages/b4/1c/125e1c936c0873796771b7f04f6c93b9f1bf5d424cea90fda94a99f61da8/opentelemetry_api-1.42.1.tar.gz"
    sha256 "56c63bea9f77b62856be8c47600474acad853b2924b99b1687c4cb6297166716"
  end

  resource "opentelemetry-exporter-otlp-proto-common" do
    url "https://files.pythonhosted.org/packages/0e/9c/216acfeaedadf2e1937f4373929b20f73197c5c4a2546d4f584b7fa63813/opentelemetry_exporter_otlp_proto_common-1.42.1.tar.gz"
    sha256 "04f1f01fb597c4249dfcd7f8b861c902c2102369d376d9d346ff38de4469a2ee"
  end

  resource "opentelemetry-exporter-otlp-proto-grpc" do
    url "https://files.pythonhosted.org/packages/87/87/ca7fc790dfdbcf4f9e9aab14a39ef1b7508ead13707e283de0b3131478d2/opentelemetry_exporter_otlp_proto_grpc-1.42.1.tar.gz"
    sha256 "975c4461f167dd8ed8857d68d3b6b25f3d272eab896f6a9470d0f5b90e2faf15"
  end

  resource "opentelemetry-exporter-otlp-proto-http" do
    url "https://files.pythonhosted.org/packages/77/32/826bfa1d80ecea24f47808de03cd4a0d13c17ecc07712f45123f0f61e4ac/opentelemetry_exporter_otlp_proto_http-1.42.1.tar.gz"
    sha256 "bf142a21035d7571ac3a09cb2e5639f49886f243972883cfe777ed3bf02b734d"
  end

  resource "opentelemetry-instrumentation" do
    url "https://files.pythonhosted.org/packages/da/6d/4de72d97ff54db1ed270c7a59c9b904b917c0ac7af429c086c388b824ddb/opentelemetry_instrumentation-0.63b1.tar.gz"
    sha256 "32368d6ae52c8de20aa790a6ad86b10a76f09956092337ae37d675773990e541"
  end

  resource "opentelemetry-instrumentation-asgi" do
    url "https://files.pythonhosted.org/packages/a0/b5/7ea3a9fd1b80e89786c14250bfaecf32a753c3fd08232690f4da8dc16e29/opentelemetry_instrumentation_asgi-0.63b1.tar.gz"
    sha256 "267b422416d768f3c7f4054883b41d9c3a7c943d86d20032b738c99a3dbb5862"
  end

  resource "opentelemetry-instrumentation-fastapi" do
    url "https://files.pythonhosted.org/packages/32/d6/0c128fac2e34b7d526a8d3c6edc45b875a97f8a987861b00511151b6337d/opentelemetry_instrumentation_fastapi-0.63b1.tar.gz"
    sha256 "cc42dff56c96d0a2921510c4abab2a4c2e27fe64b26dc1254727fb550df100ba"
  end

  resource "opentelemetry-instrumentation-httpx" do
    url "https://files.pythonhosted.org/packages/02/27/c2b4335bca030e893acbe5ff2b4f434868773bf94508be7e6bf5af981b24/opentelemetry_instrumentation_httpx-0.63b1.tar.gz"
    sha256 "f41ec82f25c3abcdada621052db3e5fd648e3b43d55eec4b9c0c5d3ecb7b4ff4"
  end

  resource "opentelemetry-proto" do
    url "https://files.pythonhosted.org/packages/b4/55/63eac3e1089b768ba014091fdd2ae8a9a440c821ef5e2b786909c94c8836/opentelemetry_proto-1.42.1.tar.gz"
    sha256 "c6a51e6b4f05ae63565f3a113217f3d2bfaec68f78c02d7a6c85f9010d1cfca6"
  end

  resource "opentelemetry-sdk" do
    url "https://files.pythonhosted.org/packages/40/f7/b390bd9bfd703bf98a68fea1f27786c6872331fd617164a54b8a59bdc008/opentelemetry_sdk-1.42.1.tar.gz"
    sha256 "8c834e8f8c9ba4171d4ec843d0cb8a67e4c7394d3f9e9297e582cbd9456ddbf7"
  end

  resource "opentelemetry-semantic-conventions" do
    url "https://files.pythonhosted.org/packages/93/99/4d7dd6df64795951413ce6e815f8cf1eb191daf7196ae86574589643d5f3/opentelemetry_semantic_conventions-0.63b1.tar.gz"
    sha256 "3daf963611334b365e98a57438183eb012d3bfb40b2d931a9af613476b8701a9"
  end

  resource "opentelemetry-util-http" do
    url "https://files.pythonhosted.org/packages/6c/d8/7bf5e4cec0578ac3c28c18eb7b88f34279139cbc8c568d6aa02b9c5ae53e/opentelemetry_util_http-0.63b1.tar.gz"
    sha256 "ba1268f00922ee522dba2ae38458060f99486e7385a8056985901ca9685adfff"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/a1/d4/1fc4078c65507b51b96ca8f8c3ba19e6a61c8253c72794544580a7b6c24d/packaging-25.0.tar.gz"
    sha256 "d443872c98d677bf60f6a1f2f8c1cb748e8fe762d2bf9d3148b5599295b0fc4f"
  end

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/42/92/cc564bf6381ff43ce1f4d06852fc19a2f11d180f23dc32d9588bee2f149d/pexpect-4.9.0.tar.gz"
    sha256 "ee7d41123f3c9911050ea2c2dac107568dc43b2d3b0c7557a33212c398ead30f"
  end

  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/a1/96/06e01a7b38dce6fe1db213e061a4602dd6032a8a97ef6c1a862537732421/prompt_toolkit-3.0.52.tar.gz"
    sha256 "28cde192929c8e7321de85de1ddbe736f1375148b02f2e17edd840042b1be855"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/66/70/e908e9c5e52ef7c3a6c7902c9dfbb34c7e29c25d2f81ade3856445fd5c94/protobuf-6.33.6.tar.gz"
    sha256 "a6768d25248312c297558af96a9f9c929e8c4cee0659cb07e780731095f38135"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e/ptyprocess-0.7.0.tar.gz"
    sha256 "5c5d0a3b48ceee0b48485e0c26037c0acd7d29765ca3fbb5cb3831d347423220"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/5c/5f/6583902b6f79b399c9c40674ac384fd9cd77805f9e6205075f828ef11fb2/pyasn1-0.6.3.tar.gz"
    sha256 "697a8ecd6d98891189184ca1fa05d1bb00e2f84b5977c481452050549c8a72cf"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/e9/e6/78ebbb10a8c8e4b61a59249394a4a594c1a7af95593dc933a349c8d00964/pyasn1_modules-0.4.2.tar.gz"
    sha256 "677091de870a80aae844b1ca6134f54652fa2c8c5a52aa396440ac3106e941e6"
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

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/82/ed/0301aeeac3e5353ef3d94b6ec08bbcabd04a72018415dcb29e588514bba8/python_dotenv-1.2.2.tar.gz"
    sha256 "2c371a91fbd7ba082c2c1dc1f8bf89ca22564a087c2c287cd9b662adde799cf3"
  end

  resource "python-multipart" do
    url "https://files.pythonhosted.org/packages/5b/42/55c32bb9b12693c092ad250a0e82edb5b31ddeda6eb772de5f308b3804ad/python_multipart-0.0.32.tar.gz"
    sha256 "be54b7f3fa167bb83e4fcd936b887b708f4e57fe75911c02aebf53efaf8d938e"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "referencing" do
    url "https://files.pythonhosted.org/packages/22/f5/df4e9027acead3ecc63e50fe1e36aca1523e1719559c499951bb4b53188f/referencing-0.37.0.tar.gz"
    sha256 "44aefc3142c5b842538163acb373e24cce6632bd54bdb01b21ad5863489f50d8"
  end

  resource "regex" do
    url "https://files.pythonhosted.org/packages/dc/0e/49aee608ad09480e7fd276898c99ec6192985fa331abe4eb3a986094490b/regex-2026.5.9.tar.gz"
    sha256 "a8234aa23ec39894bfe4a3f1b85616a7032481964a13ac6fc9f10de4f6fca270"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/e9/67/cae617f1351490c25a4b8ac3b8b63a4dda609295d8222bad12242dfdc629/rich-14.3.4.tar.gz"
    sha256 "817e02727f2b25b40ef56f5aa2217f400c8489f79ca8f46ea2b70dd5e14558a9"
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
    url "https://files.pythonhosted.org/packages/d2/1b/bc9e3e7a72dcdad7dc7888758f5d00f56f8909ed5cfdff822bd72bb4c520/sse_starlette-3.4.5.tar.gz"
    sha256 "83072538bc211a2f68b7b0422226c4af3e9b62e106e07034664b832ca019842a"
  end

  resource "starlette" do
    url "https://files.pythonhosted.org/packages/c4/68/79977123bb7be889ad680d79a40f339082c1978b5cfcf62c2d8d196873ac/starlette-0.52.1.tar.gz"
    sha256 "834edd1b0a23167694292e94f597773bc3f89f362be6effee198165a35d62933"
  end

  resource "tenacity" do
    url "https://files.pythonhosted.org/packages/47/c6/ee486fd809e357697ee8a44d3d69222b344920433d3b6666ccd9b374630c/tenacity-9.1.4.tar.gz"
    sha256 "adb31d4c263f2bd041081ab33b498309a57c77f9acf2db65aadf0898179cf93a"
  end

  resource "tiktoken" do
    url "https://files.pythonhosted.org/packages/e4/e5/5f3cb2159769d0f4324c0e9e87f9de3c4b1cd45848a96b2eb3566ad5ca77/tiktoken-0.13.0.tar.gz"
    sha256 "c9435714c3a84c2319499de9a300c0e604449dd0799ff246458b3bb6a7f433c1"
  end

  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/51/db/03eaf4331631ef6b27d6e3c9b68c54dc6f0d63d87201fed600cc409307fd/tomlkit-0.15.0.tar.gz"
    sha256 "7d1a9ecba3086638211b13814ea79c90dd54dd11993564376f3aa92271f5c7a3"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/87/d7/0535a28b1f5f24f6612fb3ff1e89fb1a8d160fee0f976e0aa6803862134b/tqdm-4.68.3.tar.gz"
    sha256 "00dfa48452b6b6cfae3dd9885636c23d3422d1ec97c66d96818cbd5e0821d482"
  end

  resource "types-requests" do
    url "https://files.pythonhosted.org/packages/e0/01/c5a19253fe1ac159159ddf9a3a07cec8bb5e486ec4d9002ad2821da0e5d2/types_requests-2.33.0.20260518.tar.gz"
    sha256 "df7bd3bfe0ca8402dfb841e7d9be714bb5578203283d66d7dc4ef69343449a5e"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/55/e3/70399cb7dd41c10ac53367ae42139cf4b1ca5f36bb3dc6c9d33acdb43655/typing_inspection-0.4.2.tar.gz"
    sha256 "ba561c48a67c5958007083d386c3295464928b01faa735ab8547c5692e87f464"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/53/0c/06f8b233b8fd13b9e5ee11424ef85419ba0d8ba0b3138bf360be2ff56953/urllib3-2.7.0.tar.gz"
    sha256 "231e0ec3b63ceb14667c67be60f2f2c40a518cb38b03af60abc813da26505f4c"
  end

  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/c4/1f/fa18009dea8469069cca78a4e877a008ab78f08b064bfc9ab891579077ff/uvicorn-0.49.0.tar.gz"
    sha256 "ebf4271aa580d9de97f93192d4595176df6e91f9aae919ca73e4fc07df1e66a3"
  end

  resource "uvloop" do
    url "https://files.pythonhosted.org/packages/06/f0/18d39dbd1971d6d62c4629cc7fa67f74821b0dc1f5a77af43719de7936a7/uvloop-0.22.1.tar.gz"
    sha256 "6c84bae345b9147082b17371e3dd5d42775bddce91f885499017f4607fdaf39f"
  end

  resource "watchfiles" do
    url "https://files.pythonhosted.org/packages/cd/41/5e1a4bb12aac5f1493fa1bdc11154eca3b258ca4eba65d39c473fe19d8e9/watchfiles-1.2.0.tar.gz"
    sha256 "c995fba777f1ea992f090f9236e9284cf7a5d1a0130dd5a3d82c598cacd76838"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/49/b4/51fe890511f0f242d07cb1ebe6a5b6db417262b9d2568b460347c57d95cc/wcwidth-0.8.1.tar.gz"
    sha256 "faf5b4a5366a72dc49cad48cdf21f52bdf63bdda995178e483ba247ff79089b9"
  end

  resource "websockets" do
    url "https://files.pythonhosted.org/packages/04/24/4b2031d72e840ce4c1ccb255f693b15c334757fc50023e4db9537080b8c4/websockets-16.0.tar.gz"
    sha256 "5f6261a5e56e8d5c42a4497b364ea24d94d9563e8fbd44e78ac40879c60179b5"
  end

  resource "wrapt" do
    url "https://files.pythonhosted.org/packages/fe/a4/282c8e64300a59fc834518a54bf0afabb4ff9218b5fa76958b450459a844/wrapt-2.2.2.tar.gz"
    sha256 "0788e321027c999bf221b667bd4a54aaefd1a36283749a860ac3eb77daed0302"
  end

  def install
    venv = virtualenv_create(libexec, "python3.14")

    # The Rust extensions (jiter, watchfiles) must leave Mach-O header padding so
    # Homebrew can rewrite their install names to the Cellar path during
    # relocation (macOS only; the flag breaks Linux ld).
    ENV.append_to_rustflags "-C link-args=-Wl,-headerpad_max_install_names" if OS.mac?

    # argon2-cffi-bindings' sdist ships an unprocessed .git_archival.txt that the
    # (build-isolated, latest) setuptools-scm parses instead of falling back to
    # PKG-INFO, so version detection fails. Pin the version it should report.
    ENV["SETUPTOOLS_SCM_PRETEND_VERSION_FOR_ARGON2_CFFI_BINDINGS"] =
      resource("argon2-cffi-bindings").version.to_s

    skip_resources = ["google-antigravity"]
    venv.pip_install resources.reject { |r| skip_resources.include?(r.name) }

    # google-antigravity ships platform wheels (py3-none-<platform>, not -any) and
    # no sdist, so install it directly wherever it is defined: copy the cached
    # download to its real filename, then pip-install it.
    if (ga = resources.find { |r| r.name == "google-antigravity" })
      whl = buildpath/ga.url.split("/").last
      cp ga.cached_download, whl
      system libexec/"bin/python", "-m", "pip", "install", "--no-deps", whl
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
  end
end
