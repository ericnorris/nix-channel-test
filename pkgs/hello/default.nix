{ stdenv, fetchurl }: stdenv.mkDerivation {
  name = "hello";

  src = fetchurl {
    url    = "mirror://gnu/hello/hello-2.3.tar.bz2";
    sha256 = "0c7vijq8y68bpr7g6dh1gny0bff8qq81vnp4ch8pjzvg56wb3js1";
  };

  patchPhase = ''
    sed -i 's/Hello, world!/Hello world from a custom Nix channel/g' src/hello.c
  '';
}
