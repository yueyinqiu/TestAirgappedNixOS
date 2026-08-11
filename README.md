1. Build the VMs:

```
nixos-rebuild build-vm --flake .#client
mkdir -p run/client
mv result run/client/vm

nixos-rebuild build-vm --flake .#server
mkdir -p run/server
mv result run/server/vm
```

2. Start the VMs

```
cd run/server
QEMU_OPTS="-netdev socket,id=net0,listen=:1234 -device virtio-net-pci,netdev=net0" ./vm/bin/run-nixos-vm
# keep it running
```

```
cd run/client
QEMU_OPTS="-netdev socket,id=net0,connect=localhost:1234 -device virtio-net-pci,netdev=net0" ./vm/bin/run-nixos-vm
# keep it running
```

3. Run the following command in the client (username: `client`, password: `1`)

```
git clone https://github.com/yueyinqiu/TestAirgappedNixOS.git
cd TestAirgappedNixOS
git checkout addfixed

bash ./client/run.sh    # It will connect the server twice. The password is also `1`.
```
