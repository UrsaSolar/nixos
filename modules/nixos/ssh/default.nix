{ config, lib, ...}:
with lib; let
  cfg = config.solarbear.ssh;
  authorized_keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
    ];
in {

  options.solarbear.ssh = {
    enable = mkEnableOption "ssh configration";
      username = mkOption {
      type = types.str;
      description = "What username to enable for SSH access.";
    };
  };

    config = mkIf cfg.enable {
        users.users.${cfg.username}.openssh.authorizedKeys.keys = authorized_keys;
  };

}
