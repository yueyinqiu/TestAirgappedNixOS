nix derivation show -r path:nixpkgs#hello > derivation.json
NixFodExporter from-derivations fod derivation.json