#!/bin/bash
# Install the SMC-PAD LED bridge as a launchd agent, so the pad lights itself.
#
# Run once per machine, from this directory:
#
#     ./install-bridge.sh
#
# What it leaves behind, and why each piece is where it is:
#
#   ~/Library/Application Support/Vibra/Vibra LED Bridge.app   the daemon,
#                                        with gatt_unlock.txt in its Resources
#   ~/Library/LaunchAgents/<label>.plist                       starts it at login
#   ~/Library/Logs/vibra-smc-pad-led-bridge.log                what it did
#
# Three things this has to get right, each learned the hard way on 2026-08-29:
#
# 1. **It is compiled, not run as a script.** `swift file.swift` needs the Xcode
#    toolchain, which is a gigabyte of build tools to carry to a venue for a
#    daemon that fits in 110 KB.
#
# 2. **It is wrapped in a .app bundle and signed**, which looks like ceremony and
#    is not. macOS gates Bluetooth behind TCC. Run from a terminal, the bridge
#    inherits the terminal's permission and works; run by launchd, a bare
#    executable has no bundle identity and no usage description, so the system
#    denies Bluetooth **silently** - the agent starts, publishes its MIDI port,
#    logs nothing wrong, and never connects to the pad. The bundle gives it an
#    identity that can hold a permission, the Info.plist string is what the
#    prompt shows, and the ad-hoc signature keeps that grant across rebuilds
#    instead of asking again every time.
#
# 3. **It starts at login, before QLC+.** The bridge publishes a virtual MIDI
#    port and QLC+ resolves its feedback patch when it loads the workspace.
#    Bridge first, QLC+ second, or QLC+ patches its feedback to whatever else
#    sits on that line and the pads stay dark.
#
# Both data files are copied out of the repo, so a running show does not depend
# on where the repo lives or on it being on the machine at all.

set -euo pipefail

LABEL="com.vibra.smc-pad-led-bridge"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$HOME/Library/Application Support/Vibra"
BUNDLE="$APP_DIR/Vibra LED Bridge.app"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
LOG="$HOME/Library/Logs/vibra-smc-pad-led-bridge.log"

if ! command -v swiftc >/dev/null; then
    echo "swiftc not found. Install Xcode's command line tools on the machine"
    echo "that builds the bundle: xcode-select --install"
    exit 1
fi

echo "Compiling..."
mkdir -p "$BUNDLE/Contents/MacOS" "$BUNDLE/Contents/Resources" \
         "$HOME/Library/LaunchAgents" "$HOME/Library/Logs"
swiftc -O "$HERE/qlc_led_bridge.swift" -o "$BUNDLE/Contents/MacOS/qlc-led-bridge"
# Inside the bundle, so double-clicking the app works: `open` passes no
# arguments, and the app has to run at least once from the Finder for macOS to
# offer the Bluetooth prompt.
cp "$HERE/reference/gatt_unlock.txt" "$BUNDLE/Contents/Resources/gatt_unlock.txt"

cat > "$BUNDLE/Contents/Info.plist" <<'INFOEOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>com.vibra.smc-pad-led-bridge</string>
    <key>CFBundleName</key>
    <string>Vibra LED Bridge</string>
    <key>CFBundleExecutable</key>
    <string>qlc-led-bridge</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>Enciende los LEDs del SMC-PAD con los colores del show.</string>
</dict>
</plist>
INFOEOF

# Ad-hoc signature: without a stable identity, macOS treats each rebuild as a
# different program and asks for Bluetooth again.
codesign --force --sign - --identifier "$LABEL" "$BUNDLE"

cat > "$PLIST" <<PLISTEOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$LABEL</string>
    <key>ProgramArguments</key>
    <array>
        <string>$BUNDLE/Contents/MacOS/qlc-led-bridge</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>ThrottleInterval</key>
    <integer>10</integer>
    <key>StandardOutPath</key>
    <string>$LOG</string>
    <key>StandardErrorPath</key>
    <string>$LOG</string>
</dict>
</plist>
PLISTEOF

echo "Loading the agent..."
launchctl bootout "gui/$UID/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$UID" "$PLIST"
launchctl kickstart -k "gui/$UID/$LABEL"

echo
echo "Installed. It starts at login and restarts itself if it dies."
echo
echo "  log:     tail -f \"$LOG\""
echo "  stop:    launchctl bootout gui/$UID/$LABEL"
echo "  start:   launchctl bootstrap gui/$UID \"$PLIST\""
echo "  restart: launchctl kickstart -k gui/$UID/$LABEL"
echo
echo "First run only: macOS asks to let 'Vibra LED Bridge' use Bluetooth. Say"
echo "yes. Without it the agent runs, publishes its MIDI port, logs nothing"
echo "wrong, and never connects - the log stops after 'bridge running' with no"
echo "'pad connected' line. If you miss the prompt, grant it by hand in"
echo "System Settings > Privacy & Security > Bluetooth, then:"
echo "  launchctl kickstart -k gui/$UID/$LABEL"
echo
echo "Then reload the workspace in QLC+, so it patches its feedback to the"
echo "bridge's MIDI port, which only exists once the bridge is running."
