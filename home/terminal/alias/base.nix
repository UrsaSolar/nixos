{ ... }:
{
  imports = [
    ./nixos.nix
  ];

  home.shellAliases = {
    
    # Shell shortcuts
    histoff = "set +o history";
    histon = "set -o history";
    
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
    
    gitsweep = "git add * && git commit -m \"Sweep\" && git push";

  };
 

}
