{lib, stdenv, fetchurl, cyrus_sasl, libevent, nixosTests }:

stdenv.mkDerivation rec {
  version = "1.6.21";
  pname   = "memcached";

  src = fetchurl {
    url    = "https://memcached.org/files/${pname}-${version}.tar.gz";
    sha256 = "sha256-x4iYDvxBfdXZPEQrHIuHafsgGIlsKd44h9IqLxQ9ou4=";
  };

  configureFlags = [
     "ac_cv_c_endian=${if stdenv.hostPlatform.isBigEndian then "big" else "little"}"
  ];

  buildInputs = [cyrus_sasl libevent];

  hardeningEnable = [ "pie" ];

  env.NIX_CFLAGS_COMPILE = toString ([ "-Wno-error=deprecated-declarations" ]
    ++ lib.optional stdenv.isDarwin "-Wno-error");

  meta = with lib; {
    description = "A distributed memory object caching system";
    homepage    = "http://memcached.org/";
    license     = licenses.bsd3;
    platforms   = platforms.linux ++ platforms.darwin;
  };

  passthru.tests = {
    smoke-tests = nixosTests.memcached;
  };
}
