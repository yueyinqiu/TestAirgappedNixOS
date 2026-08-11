nix derivation show -r .#homeConfigurations.home.activationPackage > d,json
NixFodExporter from-derivations output d.json
scp -F /dev/null -r output server@192.168.100.10:/home/server/s
ssh -F /dev/null server@192.168.100.10 "bash /home/server/s/restore.sh"
