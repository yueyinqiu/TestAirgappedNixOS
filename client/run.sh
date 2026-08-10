nix derivation show -r .#homeConfigurations.home.activationPackage > derivation.json
cat derivation.json | jq -r '.derivations | to_entries[] | select(.value.outputs.out.hash != null) | .key' > fod.txt

mapfile -t fod < fod.txt
nix-store --export "${fod[@]/#/\/nix\/store\/}" > fod.closure

scp -F /dev/null fod.closure server@192.168.100.10:/home/server/fod.closure
ssh -F /dev/null server@192.168.100.10 "nix-store --import < /home/server/fod.closure"