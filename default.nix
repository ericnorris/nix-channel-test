let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources.nixpkgs {};

  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // pkgs);

  pkgs = {
    nix-channel-test-binary = callPackage ./pkgs/nix-channel-test-binary {};
    memcached               = callPackage ./pkgs/memcached {};
  };
in pkgs
