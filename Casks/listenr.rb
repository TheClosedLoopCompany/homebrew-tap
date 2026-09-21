# Template for the Homebrew cask published to TheClosedLoopCompany/homebrew-tap.
# Scripts/release.sh substitutes 0.11.0 and 76336b26b25fad9bd87bef95e4deeefe95bcae97dadf72522f57c677860b0e42 and pushes the
# result as Casks/listenr.rb — edit THIS file, not the tap copy.
cask "listenr" do
  version "0.11.0"
  sha256 "76336b26b25fad9bd87bef95e4deeefe95bcae97dadf72522f57c677860b0e42"

  url "https://github.com/TheClosedLoopCompany/listenr-releases/releases/download/v#{version}/Listenr-#{version}.zip"
  name "Listenr"
  desc "Bot-free meeting notes with real speaker attribution"
  homepage "https://listenr.live/"

  livecheck do
    url "https://github.com/TheClosedLoopCompany/listenr-releases"
    strategy :github_latest
  end

  auto_updates true
  # ">= :sequoia" is the minimum-version form; a bare symbol pins that exact
  # macOS release and refuses to install on anything newer.
  depends_on macos: ">= :sequoia"
  depends_on arch: :arm64

  app "Listenr.app"
  # The read-only CLI + MCP server bundled inside the app.
  binary "#{appdir}/Listenr.app/Contents/MacOS/listenr"

  caveats <<~EOS
    Optional: local Whisper transcription uses whisper.cpp —
      brew install whisper-cpp
    then pick a model in Listenr's Settings → Transcription.
  EOS

  zap trash: [
    "~/Library/Application Support/Listenr",
    "~/Library/Caches/com.listenr.app",
    "~/Library/Preferences/com.listenr.app.plist",
    "~/Library/WebKit/com.listenr.app",
  ]
end
