{ lib, pkgs }: 

pkgs.stdenv.mkDerivation {
  pname = "renterd";
  version = "latest";

  src = pkgs.fetchzip {
    url = "https://github.com/SiaFoundation/renterd/releases/download/v2.0.0/renterd_linux_amd64.zip";
    sha256 = "sha256-OCpQqKpSW49Z1dMzdZK3lxCBILeDPv+e70NDDP7lg7M=";
    stripRoot = false;
  };

  installPhase = ''
    install -Dm755 renterd $out/bin/renterd
  '';

  meta = with lib; {
    description = "Sia renter daemon";
    homepage = "https://sia.tech";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ Teiwo ];
  };
}
