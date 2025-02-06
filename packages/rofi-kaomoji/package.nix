{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  waylandSupport ? true,
  x11Support ? true,
  rofi,
  wl-clipboard,
  xsel,
  xdotool
}:

stdenv.mkDerivation rec {
  pname = "rofi-kaomoji";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "Seme4eg";
    repo = "rofi-kaomoji";
    rev = "main";
    sha256 = "sha256-WAavS0C1iwyW9FQyRThKaUUTwqIXLLTAyFeZVAbcC1g=";
  };

  patches = [
    ./x11-clipboard.patch
  ];

  postPatch = ''
    patchShebangs rofi-kaomoji
  '';

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs =
    [
      rofi
    ]
    ++ lib.optionals waylandSupport [
      wl-clipboard
    ]
    ++ lib.optionals x11Support [
      xsel
      xdotool
    ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/rofi-kaomoji

    cp KAOMOJIS.md $out/share/rofi-kaomoji/
    cp rofi-kaomoji $out/bin/

    sed -i "s|\$moji_dir/KAOMOJIS.md|$out/share/rofi-kaomoji/KAOMOJIS.md|g" $out/bin/rofi-kaomoji
  '';

  postFixup = ''
    wrapProgram $out/bin/rofi-kaomoji \
      --prefix PATH : ${
        lib.makeBinPath (
          [
            rofi
          ]
          ++ lib.optionals waylandSupport [
            wl-clipboard
          ]
          ++ lib.optionals x11Support [
            xsel
            xdotool
          ]
        )
      }
  '';

  meta = with lib; {
    description = "Rofi script for selecting and copying kaomoji";
    homepage = "https://github.com/1Seme4eg/rofi-kaomoji";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ Teiwo ];
  };
}
