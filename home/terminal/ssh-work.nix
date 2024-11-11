{ ... }:

{

  programs.ssh = {
    enable = true;
    extraConfig = ''

# Always check for password
PreferredAuthentications password,keyboard-interactive,publickey

# Home
Host jupiter
    HostName 192.168.80.100
    user solarbear
    RequestTTY yes
    RemoteCommand tmux new -A -s solarbear
Host jupiter-luks
    Hostname 192.168.80.100
    Port 2222
    User root
    RequestTTY yes
    # RemoteCommand cryptroot-unlock
    IdentityFile ~/.ssh/jupiter-cryptunlock
    HostKeyAlgorithms ssh-rsa
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
Host mercury-old
    HostName 192.168.30.100
    user solarbear
Host saturn
    HostName 192.168.80.101
    user solarbear
    RequestTTY yes
    RemoteCommand tmux new -A -s solarbear
Host saturn-luks
    HostName 192.168.80.101
    user root
    StrictHostKeyChecking no
Host eunomia
    HostName 192.168.81.100
    Port 222
    user solarbear
    RequestTTY yes
    RemoteCommand tmux new -A -s solarbear
Host jupiterver
    HostName 192.168.80.100
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host saturnver
    HostName 192.168.80.101
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host mercuryver
    HostName 192.168.80.104
    user solarbear
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit

# Servers
Host xwiki
    HostName 10.131.10.62
    user techopsadmin
Host vpnradius
    HostName 10.10.10.26
    user itops
Host syslog
    HostName 10.131.10.59
    user itops
Host duoproxy
    HostName 10.131.10.118
    user techops
Host librenms
    HostName 10.131.10.140
    user techops
Host dockerhost
    HostName 10.131.10.120
    user techops
Host kiavm
    HostName 10.131.10.151
    user kenglish
Host wakeonlan
    HostName 10.11.8.39
    User wakeonlan

# Server version fetches
Host xwikiver
    HostName 10.131.10.62
    user techopsadmin
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host vpnradiusver
    HostName 10.10.10.26
    user itops
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host syslogver
    HostName 10.131.10.59
    user itops
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host duoproxyver
    HostName 10.131.10.118
    user techops
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host librenmsver
    HostName 10.131.10.140
    user techops
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host dockerhostver
    HostName 10.131.10.120
    user techops
      RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host kiavmver
    HostName 10.131.10.151
    user kenglish
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host wolver
    HostName 10.11.8.39
    User wakeonlan
    RemoteCommand sed 's/[^0-9.]//g' <<< $(cat /etc/os-release | grep "VERSION_ID") && exit
Host libremariadbver
    HostName 10.131.10.140
    user techops
    RemoteCommand sed 's/mariadb  Ver [[:digit:]]\+.[[:digit:]]\+ Distrib \([[:digit:]]\+.[[:digit:]]\+\)\.[[:digit:]]\+-MariaDB.\+/\1/g' <<< $(docker exec librenms_db mariadb -V)
Host giteapostgresqlver
    HostName 10.131.10.120
    user techops
      RemoteCommand sed 's/postgres (PostgreSQL) \([[:digit:]]\+\).\+.\+/\1/g'<<< $(docker exec gitea-postgresql postgres --version)

# Network TRs
Host tr01
        HostName 10.131.0.132
        User asm-kenglish
Host tr02
        HostName 10.131.0.134
        User asm-kenglish
Host tr03
        HostName 10.131.0.135
        User asm-kenglish
Host tr04
        HostName 10.131.0.137
        User asm-kenglish
Host tr05
        HostName 10.131.0.138
        User asm-kenglish
Host tr06
        HostName 10.131.0.139
        User asm-kenglish
Host tr07
        HostName 10.131.0.140
        User asm-kenglish
Host tr08
        HostName 10.131.0.141
        User asm-kenglish
Host tr09
        HostName 10.131.0.143
        User asm-kenglish
Host tr10
        HostName 10.131.0.144
        User asm-kenglish
Host tr11
        HostName 10.131.0.146
        User asm-kenglish
Host tr12
        HostName 10.131.0.154
        User asm-kenglish
Host tr13
        HostName 10.131.0.147
        User asm-kenglish
Host tr14
        HostName 10.131.0.149
        User asm-kenglish
Host tr15
        HostName 10.131.0.150
        User asm-kenglish
Host tr16
        HostName 10.131.0.151
        User asm-kenglish
Host tr16
        HostName 10.131.0.151
        User asm-kenglish
Host tr17
        HostName 10.131.0.152
        User asm-kenglish
Host tr18
        HostName 10.131.0.153
        User asm-kenglish
Host tr19
        HostName 10.131.0.162
        User asm-kenglish
Host tr20
        HostName 10.131.0.163
        User asm-kenglish
Host tr21
        HostName 10.131.0.164
        User asm-kenglish
Host tr22
        HostName 10.131.0.155
        User asm-kenglish
Host tr23
        HostName 10.131.0.156
        User asm-kenglish
Host tr24
        HostName 10.131.0.157
        User asm-kenglish
Host tr25
        HostName 10.131.0.158
        User asm-kenglish
Host tr26
        HostName 10.131.0.159
        User asm-kenglish
Host tr27
        HostName 10.131.0.160
        User asm-kenglish
Host tr28
        HostName 10.131.0.161
        User asm-kenglish
Host tr29
        HostName 10.131.0.167
        User asm-kenglish
Host tr30
        HostName 10.131.0.168
        User asm-kenglish
Host tr31
        HostName 10.131.0.169
        User asm-kenglish
Host tr32
        HostName 10.131.0.170
        User asm-kenglish
Host tr33
        HostName 10.131.0.165
        User asm-kenglish
Host tr34
        HostName 10.131.0.166
        User asm-kenglish
Host tr35
        HostName 10.131.0.180
        User asm-kenglish
Host tr36
        HostName 10.131.0.181
        User asm-kenglish
Host tr37
        HostName 10.131.0.171
        User asm-kenglish
Host tr38
        HostName 10.131.0.173
        User asm-kenglish
Host tr39
        HostName 10.131.0.174
        User asm-kenglish
Host tr40
        HostName 10.131.0.175
        User asm-kenglish
Host tr41
        HostName 10.131.0.177
        User asm-kenglish
Host tr42
        HostName 10.131.0.179
        User asm-kenglish
Host tr43
        HostName 10.131.0.187
        User asm-kenglish
Host tr44
        HostName 10.131.0.188
        User asm-kenglish
Host tr45
        HostName 10.131.0.183
        User asm-kenglish
Host tr46
        HostName 10.131.0.184
        User asm-kenglish
Host tr47
        HostName 10.131.0.185
        User asm-kenglish
Host tr48
        HostName 10.131.0.186
        User asm-kenglish
Host tr49
        HostName 10.131.0.192
        User asm-kenglish
Host tr50
        HostName 10.131.0.189
        User asm-kenglish
Host tr51
        HostName 10.131.0.190
        User asm-kenglish
Host tr52
        HostName 10.131.0.191
        User asm-kenglish
Host tr53
        HostName 10.131.0.193
        User asm-kenglish
Host tr55
        HostName 10.131.0.194
        User asm-kenglish
Host tr56
        HostName 10.131.1.56
        User asm-kenglish
Host tr57
        HostName 10.131.1.57
        User asm-kenglish
Host tr59
        HostName 10.131.0.195
        User asm-kenglish
Host tr62
        HostName 10.131.0.182
        User asm-kenglish
Host tr63
        HostName 10.131.0.199
        User asm-kenglish
    '';
  };
  
}
