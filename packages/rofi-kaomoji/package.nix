{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  waylandSupport ? false,
}:

stdenv.mkDerivation rec {
  pname = "rofi-kaomoji";
  version = "2025-01-21";

  src = fetchFromGitHub {
    owner = "Seme4eg";
    repo = "rofi-kaomoji";
    rev = "1a1538e886ffb5eb65aed08b69f918594a621a04";
    sha256 = "sha256-vUmGR09WfovX5ZQ6Ydx2jnSEI3rwVQq+2bWvOp+PUXc=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  buildInputs =
    with pkgs;
    [
      rofi
      gawk
      coreutils
      gnused
      gnugrep
    ]
    ++ lib.optionals stdenv.isLinux [
      (if waylandSupport then wl-clipboard else xclip)
    ];

  patches =
    [
    ]
    ++ lib.optionals (!waylandSupport) [
      ./wayland-to-xorg.patch
    ];

  postPatch = ''
    patchShebangs rofi-kaomoji
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 rofi-kaomoji $out/bin/rofi-kaomoji
    install -m644 KAOMOJIS.md $out/bin/KAOMOJIS.md

    wrapProgram $out/bin/rofi-kaomoji \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';

  meta = with lib; {
    description = "Simple script to search through the collection of kaomoji and copy selected one to your clipboard";
    homepage = "https://github.com/Seme4eg/rofi-kaomoji";
    license = licenses.mit;
    maintainers = [ "Teiwo" ];
    platforms = platforms.linux;
  };
}
