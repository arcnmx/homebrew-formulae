class RxvtUnicodeTerminfo < Formula
  desc "Terminfo files for urxvt"
  homepage "http://software.schmorp.de/pkg/rxvt-unicode.html"
  url "http://dist.schmorp.de/rxvt-unicode/Attic/rxvt-unicode-9.22.tar.bz2"
  sha256 "e94628e9bcfa0adb1115d83649f898d6edb4baced44f5d5b769c2eeb8b95addd"

  def install
    (share/"terminfo").mkpath
    system "tic", "-x", "-o", "#{share}/terminfo", "./doc/etc/rxvt-unicode.terminfo"
  end
end
