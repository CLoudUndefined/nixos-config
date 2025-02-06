{
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "master";
    sha256 = "sha256-9X8AimMNX08Q2QXb3OMcZi1uEdrz5NVNrbnFtK7fTYo=";
  };

  vendorHash = "sha256-5UnWBWYm7uyeDF1J9kdvJqpBJ8SQvB+IwFCwCje+uS8=";

  meta = with lib; {
    description = "GO Simple Tunnel - a simple tunnel written in golang";
    homepage = "https://github.com/go-gost/gost";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ Teiwo ];
  };
}
