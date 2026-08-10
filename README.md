```
nixos-rebuild build-vm --flake .#client
mv result run/client/vm

nixos-rebuild build-vm --flake .#server
mv result run/server/vm
```

```
cd run/client
QEMU_OPTS="-netdev socket,id=net0,listen=:1234 -device virtio-net-pci,netdev=net0" ./vm/bin/run-nixos-vm
```

```
cd run/server
QEMU_OPTS="-netdev socket,id=net0,connect=localhost:1234 -device virtio-net-pci,netdev=net0" ./vm/bin/run-nixos-vm
```