nix derivation show -r .#homeConfigurations.home.activationPackage > derivation.json
NixFodExporter from-derivations output derivation.json
scp -F /dev/null -r . server@192.168.100.10:/home/server/repo
ssh -F /dev/null server@192.168.100.10 "bash /home/server/repo/store.sh"
ssh -F /dev/null server@192.168.100.10 "nix build /home/server/repo#homeConfigurations.home.activationPackage"
