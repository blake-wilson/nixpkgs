{ lib, stdenv, fetchurl, makeWrapper, jre_headless }:

stdenv.mkDerivation rec {
  pname = "ktlint";
  version = "0.43.0";

  src = fetchurl {
    url = "https://github.com/pinterest/ktlint/releases/download/${version}/ktlint";
    sha256 = "0vrfxmqnwwgij8hrcbzp3j0vg90w55r6kw4zhqmjsnnsg29gc82s";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    install -Dm755 $src $out/bin/ktlint
  '';

  postFixup = ''
    wrapProgram $out/bin/ktlint --prefix PATH : "${jre_headless}/bin"
  '';

  meta = with lib; {
    description = "An anti-bikeshedding Kotlin linter with built-in formatter";
    homepage = "https://ktlint.github.io/";
    license = licenses.mit;
    platforms = jre_headless.meta.platforms;
    maintainers = with maintainers; [ tadfisher SubhrajyotiSen ];
  };
}
