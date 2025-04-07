{ ... }:

let
  authorized_keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEo3x748XXr/ftMkd9KWCwRXvcRj/ftBSMK/FLGx8JUn solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINivT/RWXZhBr4CUXGlsmHzq9QQDsJ7w009gKpetqgfY kenglish@nixos-wsl"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYunoMPbBUTXFbLL0vu2Gbwh6NaEt9gJadM6rk02Lcb deck@GabeBoy"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINzaRL6I6g7t1upSFY/t9PZ5H7RZTOG2o0//IO0IcfcL root@mercury"
    ];
in

{

  services.openssh = {
    enable = true;
    ports = [ 222 ];
    openFirewall = true;
    settings = { 
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      PrintLastLog = false;
      PrintMotd = true;
    };
  };  

  users.users.solarbear.openssh.authorizedKeys.keys = authorized_keys;

}
