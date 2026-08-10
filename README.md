```
nixos-rebuild build-vm --flake .#client
mv result run/client/vm

nixos-rebuild build-vm --flake .#server
mv result run/server/vm
```