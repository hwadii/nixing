host := `uname -n`

rebuild-local:
    nixos-rebuild --flake .#{{host}} switch --sudo

rebuild target:
    nixos-rebuild --flake .#{{target}} switch --sudo --target-host {{target}} --build-host {{target}}
