{ ... }:

{

  programs.ssh = {
    enable = true;
    extraConfig = ''

PreferredAuthentications publickey,password,keyboard-interactive

Host jupiter
    HostName 192.168.80.100
    Port 222
    user solarbear
    RequestTTY yes
    RemoteCommand tmux new -A -s solarbear
Host mercury
    HostName 192.168.80.104
    Port 222
    user solarbear
    RequestTTY yes
    RemoteCommand tmux new -A -s solarbear
Host mercury-luks
    HostName 192.168.80.104
    user root
    StrictHostKeyChecking no
Host saturn
    HostName 192.168.80.101
    Port 222
    user solarbear
    RequestTTY yes
    RemoteCommand tmux new -A -s solarbear
Host saturn-luks
    HostName 192.168.80.101
    user root
    StrictHostKeyChecking no

    '';
  };
  
}
