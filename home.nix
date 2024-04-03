{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kenglish";
  home.homeDirectory = "/home/kenglish";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kenglish/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    XDG_DATA_HOME="$HOME/.local/share";
    XDG_CONFIG_HOME="$HOME/.config";
    XDG_STATE_HOME="$HOME/.local/state";
    XDG_CACHE_HOME="$HOME/.cache";

    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Let Home Manager manage .bashrc
  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
    '';
    shellAliases = {
      # Shell shortcuts
      histoff = "set +o history";
      histon = "set -o history";
      hist = "cat $XDG_STATE_HOME/zsh/history | grep $@";

      # Fuzzy finder directory hopper
      jj = "clear && cd $(find ~/Software/ ~/.config/ ~/Documents -type d | fzf)";
      vv = "clear && vim $(find ~/Software/ ~/.config/ ~/Documents ~/Downloads ~/.vim ~/.bashrc -type f | fzf)";

      nxsync = "nextcloudcmd -n --path /Notes ~/Notes https://io.ursa.solar/";
      sshhosts = "grep '^Host' ~/.ssh/config | cut -d ' ' -f 2- | column";
    };
  };
  programs.fzf = {
    enable = true;
    colors = {
      "bg+" = "#313244";
      "bg" = "#1e1e2e";
      "spinner" = "#f5e0dc";
      "hl" = "#f38ba8";
      "fg" = "#cdd6f4";
      "header" = "#f38ba8";
      "info" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#f5e0dc";
      "fg+" = "#cdd6f4";
      "prompt" = "#cba6f7";
      "hl+" = "#f38ba8";
      };
  };
}
