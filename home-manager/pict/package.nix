{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "pict";
  version = "3.7.4-unstable-2026-09-08";
  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "pict";
    rev = "ab76c2548f551fcb46314e58653a1bd1172f3a72";
    hash = "sha256-wupY9aMEGsdSmCbBigkAnzBeNEvFSK1qQz2R++3EGjU=";
  };

  nativeBuildInputs = [ cmake ];

  meta = {
    description = "Pairwise Independent Combinatorial Testing tool";
    homepage = "https://github.com/microsoft/pict";
    license = lib.licenses.mit;
    mainProgram = "pict";
  };
}
