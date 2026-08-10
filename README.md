```
nixos-rebuild build-vm --flake .#client
mv result run/client/vm

nixos-rebuild build-vm --flake .#server
mv result run/server/vm
```

```
cd run/client
./vm/bin/run-nixos-vm
```

```
cd run/server
./vm/bin/run-nixos-vm
```