class Implicitcad < Formula
  desc "Math-inspired, programmatic CAD (ExtOpenSCAD)"
  homepage "https://implicitcad.org/"
  url "https://github.com/Haskell-Things/ImplicitCAD/archive/refs/tags/v0.4.1.0.tar.gz"
  sha256 "ade1438dcbf4ba663c12fbc42d5044ecbee8862831c877a49f192434fbd75d4c"
  license "AGPL-3.0-or-later"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  uses_from_macos "zlib"

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    assert_match "Usage", shell_output("#{bin}/extopenscad --help")
    (testpath/"t.escad").write "circle(10);"
    system "#{bin}/extopenscad", "t.escad"
    assert_predicate testpath/"t.svg", :exist?
  end
end
