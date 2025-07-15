{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "bf4d01732084be29cedefe9815731700da865956";
    sha256 = "1sj9b381gh6xpp336lq1by5qsa54chqcgq37r8daqbp2igp8dh14";
  };
#The following does not work
  #patchPhase = ''
  #  find . -type f -name "metadata.desktop" -print0 | xargs -0 sed -i -e 's|ConfigFile=Themes/astronaut.conf|ConfigFile=Themes/pixel_sakura.conf|g'
  #'';
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
