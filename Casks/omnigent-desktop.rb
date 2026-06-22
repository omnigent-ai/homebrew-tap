cask "omnigent-desktop" do
  version :latest
  sha256 :no_check

  url "https://www.omnigent.ai/download/mac"
  name "Omnigent"
  desc "Desktop app for the Omnigent AI agent platform"
  homepage "https://www.omnigent.ai/"

  livecheck do
    skip "No version information available from the download URL"
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Omnigent.app"

  zap trash: [
    "~/Library/Application Support/Omnigent",
    "~/Library/Caches/ai.omnigent.desktop",
    "~/Library/HTTPStorages/ai.omnigent.desktop",
    "~/Library/Preferences/ai.omnigent.desktop.plist",
    "~/Library/Saved Application State/ai.omnigent.desktop.savedState",
  ]
end
