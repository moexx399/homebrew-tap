# Generated for each release by packaging/homebrew/formula.py in moexx399/golf_simulator_launcher: edits are overwritten.
class GolfSimulatorLauncher < Formula
  desc "Full-screen, touch-friendly menu for booting golf simulators"
  homepage "https://github.com/moexx399/golf_simulator_launcher"
  version "0.1.0"
  license "MIT"

  depends_on "tesseract"

  on_macos do
    on_arm do
      url "https://github.com/moexx399/golf_simulator_launcher/releases/download/v0.1.0/golf_simulator_launcher-macos-arm64.tar.gz"
      sha256 "27254542c4e6d9b031636d5880166fd6348f5155797a058c97cfa6447ededf58"
    end
    on_intel do
      url "https://github.com/moexx399/golf_simulator_launcher/releases/download/v0.1.0/golf_simulator_launcher-macos-x64.tar.gz"
      sha256 "b7b734097159b872e8d6cec9d81f7c6128072151d47c2104d0e77f4eb0a0ff0f"
    end
    depends_on "cliclick"
  end

  on_linux do
    on_intel do
      url "https://github.com/moexx399/golf_simulator_launcher/releases/download/v0.1.0/golf_simulator_launcher-linux-x64.tar.gz"
      sha256 "96cb00a2ce79b3d03d6fe9031572a4be72b1766c984bf386d52508c9e7fb55c0"
    end
    depends_on "imagemagick"
    depends_on "xdotool"
    depends_on "xwininfo"
  end

  # A prebuilt bundle: its files are all where it expects them.
  skip_clean "libexec"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"golf_simulator_launcher"
  end

  def caveats
    <<~EOS
      Your launcher.json and launcher.log are kept in your user data folder:
        #{OS.mac? ? "~/Library/Application Support/golf_simulator_launcher" : "~/.local/share/golf_simulator_launcher"}
      The simulators in the sample config are Windows programs and need Wine or similar.
      Try it without starting anything: golf_simulator_launcher --windowed --dry-run
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/golf_simulator_launcher --version")
  end
end
