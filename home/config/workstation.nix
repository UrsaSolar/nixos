{ ... }:

{
  
  imports = [
    ../terminal/terminal.nix
    ../terminal/alias/workstation.nix
  ];

  home.shellAliases = {
    hm-rebuild = "home-manager switch --flake $NIXOSDIR && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
  };
  services.ssh-agent.enable = true;
}
