class ClaudeTitle < Formula
  desc "Show Claude Code's status in the terminal tab title."
  homepage "https://github.com/tylerlaprade/claude-title"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.11/claude-title-aarch64-apple-darwin.tar.xz"
      sha256 "72d0d1f5e9079cdbe889be2409f0e883f1fc325afe537372af98eccd3db43b7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.11/claude-title-x86_64-apple-darwin.tar.xz"
      sha256 "17b1d03dc6eb9785cc57e846bd3299a57a3fbb81cacdc64b4986db01034f2ca4"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.11/claude-title-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4779e1beb98a696b728d4c73ca6f1aa0c333511ab16763cdbb1af48070d1d34"
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
