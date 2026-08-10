nix derivation show -r .#homeConfigurations.home.activationPackage > derivation.json
cat derivation.json | jq -r '.derivations | to_entries[] | select(.value.outputs.out.hash != null) | .key' > fod.txt

mapfile -t fod < fod.txt
nix-store --export "${fod[@]/#/\/nix\/store\/}" > fod.closure