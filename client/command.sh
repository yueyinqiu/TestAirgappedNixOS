nix derivation show -r .#homeConfigurations.home.activationPackage > derivation.json
cat derivation.json | jq -r '.derivations | to_entries[] | select(.value.outputs.out.hash != null) | .key' > fod.txt
nix-store --export "${fixedOutputDerivations[@]}" > source-export.closure