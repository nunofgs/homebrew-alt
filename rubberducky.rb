require 'formula'

class Rubberducky < Formula
  homepage 'https://github.com/j0sh/rubberducky'
  head 'https://github.com/j0sh/rubberducky.git'

  depends_on 'rtmpdump'
  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'libev'
  depends_on 'openssl'

  def install
    chmod 0755, 'autogen.sh'
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install" # if this fails, try separate make/make install steps
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test rubberducky`.
    system rubberducky
  end
end
