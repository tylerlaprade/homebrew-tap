class ClaudeTitle < Formula
  desc "Show Claude Code's status in the terminal tab title"
  homepage "https://github.com/tylerlaprade/claude-title"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.4/claude-title-aarch64-apple-darwin.tar.xz"
      sha256 "3934730c603ea7349bfc1a2a644c81e8b959539bd2e082f3ea7e1c8cd467072c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.4/claude-title-x86_64-apple-darwin.tar.xz"
      sha256 "3668d6ac483c8a1e12fb2f582f98a8d49b29f47434260121f164df3ba5cb7253"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.4/claude-title-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b93a6ce223bc3180ada6893b4d2f8768e6737a43f0a84059ecfe427d3c8888f4"
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
