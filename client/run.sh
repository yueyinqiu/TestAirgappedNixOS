nix derivation show -r nixpkgs#hello > derivation.json
NixFodExporter from-derivations output derivation.json

scp -F /dev/null -r output server@192.168.100.10:/home/server/fod
ssh -F /dev/null server@192.168.100.10 "bash /home/server/fod/store.sh"

git clone --depth 1 https://github.com/NixOS/nixpkgs.git
scp -F /dev/null -r nixpkgs server@192.168.100.10:/home/server/nixpkgs
ssh -F /dev/null server@192.168.100.10 "nix shell --override-flake nixpkgs path:/home/server/nixpkgs nixpkgs#hello --offline --extra-experimental-features flakes --extra-experimental-features nix-command"
