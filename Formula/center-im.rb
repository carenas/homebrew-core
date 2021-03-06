class CenterIm < Formula
  desc "Text-mode multi-protocol instant messaging client"
  homepage "https://www.centerim.org/index.php/Main_Page"
  url "https://www.centerim.org/download/releases/centerim-4.22.10.tar.gz"
  sha256 "93ce15eb9c834a4939b5aa0846d5c6023ec2953214daf8dc26c85ceaa4413f6e"
  revision 1

  bottle do
    rebuild 1
    sha256 "f75ad82d6a94767e1db97ff86a1a9e7fd97b53bdfbda02281f7732ec960d6bd6" => :mojave
    sha256 "800a4ecf2a11219b619134a85ba492b8256a48d3363135f711da9ca8aab34139" => :high_sierra
    sha256 "5f7c56eb5b9cc982df5a17c5cd043ac4968de36e396c219e0f544e9e34e46669" => :sierra
    sha256 "315556554c3e5b972b0d99145fd6d0971837c2bbd981b849ca89e7a9c069335b" => :el_capitan
    sha256 "5a51f0130fcd601aeed50ae6f66008aaa0ec96f6ac3e7bc828b627f04b46b9f2" => :yosemite
    sha256 "673992c76745d9509dd32e71c964946018584db447b37d02a21f332b508c619d" => :mavericks
    sha256 "934ab216ab1f6eb9033cfb1bbbe720f2a7fa5190eb64c245d2140694c832a965" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "openssl"

  # Fix build with clang; 4.22.10 is an outdated release and 5.0 is a rewrite,
  # so this is not reported upstream
  patch :DATA

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/677cb38/center-im/patch-libjabber_jconn.c.diff"
    sha256 "ed8d10075c23c7dec2a782214cb53be05b11c04e617350f6f559f3c3bf803cfe"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-msn",
                          "--with-openssl=#{Formula["openssl"].opt_prefix}"
    system "make", "install"

    # /bin/gawk does not exist on macOS
    inreplace bin/"cimformathistory", "/bin/gawk", "/usr/bin/awk"
  end

  test do
    assert_match /trillian/, shell_output("#{bin}/cimconv")
  end
end

__END__
diff --git a/libicq2000/libicq2000/sigslot.h b/libicq2000/libicq2000/sigslot.h
index b7509c0..024774f 100644
--- a/libicq2000/libicq2000/sigslot.h
+++ b/libicq2000/libicq2000/sigslot.h
@@ -82,6 +82,7 @@
 #ifndef SIGSLOT_H__
 #define SIGSLOT_H__
 
+#include <cstdlib>
 #include <set>
 #include <list>
 
