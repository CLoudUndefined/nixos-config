{
  lib,
  pkgs,
  kernel ? pkgs.linuxPackages.kernel,
}:

pkgs.stdenv.mkDerivation {
  pname = "opengigabyte";
  version = "0.0.2";
  src = pkgs.fetchFromGitHub {
    owner = "blmhemu";
    repo = "opengigabyte";
    rev = "v0.0.2";
    sha256 = "sha256-K1QFuZVGMYrVc8Y3TI0RXuJCzcPv0aRkJq/IJARin8U=";
  };

  buildInputs = [ pkgs.libelf ];

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD/driver modules
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
    cp driver/*.ko $out/lib/modules/${kernel.modDirVersion}/extra/
  '';

  meta = with lib; {
    description = "OpenGigabyte kernel module for controlling Gigabyte input devices";
    homepage = "https://github.com/blmhemu/opengigabyte";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ Teiwo ];
  };
}
