{ system ? builtins.currentSystem }:
let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources.nixpkgs { inherit system; };

  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // pkgs);

  pkgs = {
    hello      = callPackage ./pkgs/hello {};
    memcached  = callPackage ./pkgs/memcached {};
  };
in pkgs
