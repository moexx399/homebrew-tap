# Generated for each release by packaging/homebrew/formula.py in moexx399/square_impact: edits are overwritten.
class SquareImpact < Formula
  desc "Instant high-speed replays from the Square Omni launch monitor's own cameras"
  homepage "https://github.com/moexx399/square_impact"
  version "0.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/moexx399/square_impact/releases/download/v0.16.0/square_impact-macos-arm64.zip"
      sha256 "de58fd8fbf31cad71dcf8b2425ca26e039612be16f116b0b8b99098211ff9934"
    end
    on_intel do
      url "https://github.com/moexx399/square_impact/releases/download/v0.16.0/square_impact-macos-x64.zip"
      sha256 "847ca60189e934d07ea537c14dfe707e9b1286aad2473b7c3f5cc4210b1a787e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/moexx399/square_impact/releases/download/v0.16.0/square_impact-linux-x64.zip"
      sha256 "fbe6cc8539b142914cfd1ca72b4b92617092e555dd623e91a57fd9c2c5febe30"
    end
  end

  def install
    # one self-contained executable, adb built in
    chmod 0755, "square_impact"
    bin.install "square_impact"
    doc.install "README.md", "CHANGELOG.md"
    (share/"square_impact").install "adb-NOTICE.txt"
  end

  def caveats
    s = <<~EOS
      Shots and settings (square_impact.json) are kept in your user data folder:
        #{OS.mac? ? "~/Library/Application Support/square_impact" : "~/.local/share/square_impact"}
      Settings page while it runs: http://localhost:8765/settings
      Update with: brew upgrade square_impact
    EOS
    if OS.linux?
      s += <<~EOS

        Linux: adb needs permission to open the Omni's USB device without root.
        Add a udev rule, then unplug and replug the Omni:
          sudo tee /etc/udev/rules.d/51-square-omni.rules <<'RULE'
          SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d002", MODE="0660", TAG+="uaccess"
          RULE
          sudo udevadm control --reload-rules
      EOS
    end
    s
  end

  test do
    assert_match "square_impact", shell_output("#{bin}/square_impact --help")
  end
end
