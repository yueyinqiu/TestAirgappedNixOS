ssh -F /dev/null server@192.168.100.10 "nix shell --extra-experimental-features flakes --extra-experimental-features nix-command path:/home/server/nixpkgs#hello"
