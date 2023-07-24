{ writeShellScriptBin }:

writeShellScriptBin "nix-channel-test-binary" ''
echo "Hello world from a nix channel"
''
