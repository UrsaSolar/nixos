{ ... }:

let
  authorized_keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINivT/RWXZhBr4CUXGlsmHzq9QQDsJ7w009gKpetqgfY kenglish@nixos-wsl"
    ];
in

{

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = { 
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      PrintLastLog = false;
      PrintMotd = true;
    };
  };  
  
  users.users.solarbear.openssh.authorizedKeys.keys = authorized_keys;

  # SSH Unlocking - https://wiki.nixos.org/w/index.php?title=Remote_disk_unlocking
  boot.initrd = {
    availableKernelModules = [ "igc" ];
    network = {
      enable = true;
      udhcpc.enable = true;
      flushBeforeStage2 = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = authorized_keys;
        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      };
      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';
    };
  };


}
