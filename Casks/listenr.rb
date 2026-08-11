# Template for the Homebrew cask published to TheClosedLoopCompany/homebrew-tap.
# Scripts/release.sh substitutes 0.1.5 and 4751a54f80d0b1081788fdf8825d89a2a51e8e84ce0d2db1446981ec8a355064 and pushes the
# result as Casks/listenr.rb — edit THIS file, not the tap copy.
cask "listenr" do
  version "0.1.5"
  sha256 "4751a54f80d0b1081788fdf8825d89a2a51e8e84ce0d2db1446981ec8a355064"

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
