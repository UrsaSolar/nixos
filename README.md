Initial configuration:
`nix.settings.experimental-features = [ "nix-command" "flakes" ];`

Home Manager:
```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```
