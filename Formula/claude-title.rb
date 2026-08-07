class ClaudeTitle < Formula
  desc "Show Claude Code's live state in the terminal tab title."
  homepage "https://github.com/tylerlaprade/claude-title"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.2/claude-title-aarch64-apple-darwin.tar.xz"
      sha256 "d4f41e467208c2250291aecbb7e5ddd328ae653febaa742a44a90208c88f385b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.2/claude-title-x86_64-apple-darwin.tar.xz"
      sha256 "ea6b03d2c7d5c8b78c3e46e162d8f34b04efb2def422b6edc01546c14c916395"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.2/claude-title-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5de3f092646e6a5c5be2b0c5788e58ca4dccb6b98a6fd3d876432867fc8c97e3"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "claude-title"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "claude-title"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "claude-title"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
