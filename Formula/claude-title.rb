class ClaudeTitle < Formula
  desc "Show Claude Code's status in the terminal tab title."
  homepage "https://github.com/tylerlaprade/claude-title"
  version "0.1.19"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.19/claude-title-aarch64-apple-darwin.tar.xz"
      sha256 "65e79379329ca203032441f217e23a66da35a3525cf722800c0f060851aea9a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.19/claude-title-x86_64-apple-darwin.tar.xz"
      sha256 "77f1599639fdef4ccf24be3a6d6b43bfe0b628df77b8fb532d109d16663644f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.19/claude-title-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47cb5512be44836c0bb9c4bce2aac20d89d3056b7b630f0a919c19cea273c802"
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
