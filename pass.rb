class Pass < Formula
  desc "Password manager"
  homepage "https://www.passwordstore.org/"
  url "https://git.zx2c4.com/password-store/snapshot/password-store-1.7.1.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/p/password-store/password-store_1.7.1.orig.tar.xz"
  sha256 "f6d2199593398aaefeaa55e21daddfb7f1073e9e096af6d887126141e99d9869"

  head "https://git.zx2c4.com/password-store", :using => :git

  depends_on "qrencode"
  depends_on "tree"
  depends_on "gnu-getopt"
  depends_on :gpg => :run

  def install
    system "make", "PREFIX=#{HOMEBREW_PREFIX}", "DESTDIR=#{prefix}", "WITH_ALLCOMP=yes", "BASHCOMPDIR=#{bash_completion}", "ZSHCOMPDIR=#{zsh_completion}", "FISHCOMPDIR=#{fish_completion}", "install"
    prefix.install Dir["#{prefix}#{prefix}/*"]
    prefix.install Dir["#{prefix}#{HOMEBREW_PREFIX}/*"]
    elisp.install "contrib/emacs/password-store.el"
    pkgshare.install "contrib"
  end

  test do
    (testpath/"batch.gpg").write <<~EOS
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS
    begin
      system Formula["gnupg"].opt_bin/"gpg", "--batch", "--gen-key", "batch.gpg"
      system bin/"pass", "init", "Testing"
      system bin/"pass", "generate", "Email/testing@foo.bar", "15"
      assert_predicate testpath/".password-store/Email/testing@foo.bar.gpg", :exist?
    ensure
      system Formula["gnupg"].opt_bin/"gpgconf", "--kill", "gpg-agent"
    end
  end
end
