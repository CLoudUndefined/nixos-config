{ lib, pkgs }: 

pkgs.stdenv.mkDerivation {
  pname = "renterd";
  version = "latest";

  src = pkgs.fetchzip {
    url = "https://sia.tech/downloads/latest/renterd_linux_amd64.zip";
    sha256 = "sha256-nUNRGL02aAicxoggFvs8poVrMFUiuJxYeQUxj45QUx0=";
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
