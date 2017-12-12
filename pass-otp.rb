class PassOtp < Formula
  desc "pass-otp"
  homepage "https://github.com/tadfisher/pass-otp"
  version "1.0.0"

  url "https://github.com/tadfisher/pass-otp.git",
    :tag => "v1.0.0"

  depends_on "oath-toolkit"

  def install
    install_path = lib/"password-store"/"extensions"
    install_path.install "otp.bash"
    man1.install "pass-otp.1"
  end
end
