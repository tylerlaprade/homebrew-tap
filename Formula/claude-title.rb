class ClaudeTitle < Formula
  desc "Show Claude Code's status in the terminal tab title."
  homepage "https://github.com/tylerlaprade/claude-title"
  version "0.1.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.12/claude-title-aarch64-apple-darwin.tar.xz"
      sha256 "3d0dc9387bf0090c9dc260f5d2933fa89d898a33e026a0dab271cf31f58f5019"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.12/claude-title-x86_64-apple-darwin.tar.xz"
      sha256 "fd7137052db5edb5f0a8e8389decc006ace0de12351b5707ca4dd34629c9c27d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/tylerlaprade/claude-title/releases/download/v0.1.12/claude-title-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eba25649fc2f95bc9c3069b613ffd9585a9b4045b335bfe4cd659f258dbaa4a9"
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
