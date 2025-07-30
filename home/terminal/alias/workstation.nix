{ ... }:{

 home.shellAliases = {

    zrl = "source $XDG_CONFIG_HOME/zsh/.zshrc";
    wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
    # Fuzzy finder & directory hoppers
    jj = "clear && cd $(find ~/Software/ ~/.config/ ~/Documents -type d | fbat)";
    vv = "clear && nvim $(find ~/Software/ ~/.config/ ~/Documents ~/Downloads -type f | fbat)";
    fzbat = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    fzgrep = "grep --line-buffered --color=never -r \"\" * | fzf";

    # Replacements
    ls = "eza --icons=always";
    cat = "bat";
    catplain = "bat --style=plain";
    duf = "duf --hide special";

  };
}
