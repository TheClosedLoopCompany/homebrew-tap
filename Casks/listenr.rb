# Template for the Homebrew cask published to TheClosedLoopCompany/homebrew-tap.
# Scripts/release.sh substitutes 0.2.0 and df85365061da72da9d525bb5c5b7c43f19cf5109c3812244dc2a5385816c8d00 and pushes the
# result as Casks/listenr.rb — edit THIS file, not the tap copy.
cask "listenr" do
  version "0.2.0"
  sha256 "df85365061da72da9d525bb5c5b7c43f19cf5109c3812244dc2a5385816c8d00"

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
