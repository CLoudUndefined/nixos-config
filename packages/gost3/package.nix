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
    rev = "f61bb2fd72ecbe8cc7566a2f345c8b2e734eb93d";
    sha256 = "sha256-EV0V9ke8Kx1A1c+d59NpWBevlK/w+VY6DPJhw/9wBiA=";
  };

  vendorHash = "sha256-QsQxW16kCI06aFyHT+ImB1DUd5Gjp8MS1paWq/trnBk=";

  meta = with lib; {
    description = "GO Simple Tunnel - a simple tunnel written in golang";
    homepage = "https://github.com/go-gost/gost";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ Teiwo ];
  };
}
