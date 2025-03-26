{ pkgs, lib, config, ... }:

{

  imports = [
    ../../system/config/base.nix
    ../../system/config/workstation.nix
    ../../system/users/kenglish.nix
    ../../system/users/ssh.nix
    ../../system/pkgs/base.nix
    ../../system/pkgs/workstation.nix
    ../../system/pkgs/unfree.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "kenglish";

  # When the config is built from a flake, the NIX_PATH entry of nixxpkgs is set to its flake version.
  # Per default the resulting systems aren't flake-enabled, so rebuilds would fail.
  # Note: This does not affect the module being imported into your own flake.
  nixpkgs.flake.source = lib.mkForce null;

  systemd.tmpfiles.rules =
    let
      channels = pkgs.runCommand "default-channels" { } ''
        mkdir -p $out
        ln -s ${pkgs.path} $out/nixos
        ln -s ${./.} $out/nixos-wsl
      '';
    in
    [
      "L /nix/var/nix/profiles/per-user/root/channels-1-link - - - - ${channels}"
      "L /nix/var/nix/profiles/per-user/root/channels - - - - channels-1-link"
    ];
  system.stateVersion = config.system.nixos.release;

  networking.hostName = "nixos-wsl";
  networking.networkmanager.enable = lib.mkForce false;
  networking.firewall.enable = false; # Not needed due to host firewall

  security.pki.certificates = [
    # Alleigant-stadium-root.crt
    ''-----BEGIN CERTIFICATE-----
MIIEPTCCAyWgAwIBAgIUDykUTGtkY9oKETJbvATFcd9Gt/owDQYJKoZIhvcNAQEL
BQAwga0xCzAJBgNVBAYTAlVTMQ8wDQYDVQQIDAZOZXZhZGExEjAQBgNVBAcMCUxh
cyBWZWdhczEaMBgGA1UECgwRQWxsZWdpYW50IFN0YWRpdW0xHjAcBgNVBAsMFVRl
Y2hub2xvZ3kgT3BlcmF0aW9uczESMBAGA1UEAwwJbHZzLmxvY2FsMSkwJwYJKoZI
hvcNAQkBFhppdG9wc0BhbGxlZ2lhbnRzdGFkaXVtLmNvbTAeFw0yMzA2MDYwODE2
MTRaFw0zMzA2MDMwODE2MTRaMIGtMQswCQYDVQQGEwJVUzEPMA0GA1UECAwGTmV2
YWRhMRIwEAYDVQQHDAlMYXMgVmVnYXMxGjAYBgNVBAoMEUFsbGVnaWFudCBTdGFk
aXVtMR4wHAYDVQQLDBVUZWNobm9sb2d5IE9wZXJhdGlvbnMxEjAQBgNVBAMMCWx2
cy5sb2NhbDEpMCcGCSqGSIb3DQEJARYaaXRvcHNAYWxsZWdpYW50c3RhZGl1bS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8Nh5wRWYzQuPT6CXN
sh9+0HAOtGeyBGvTCb4IHJVpmVF48aD/4g1XTiMnGR2Qg1CKMF/Ufp2rcG7eAaYp
VT3/SZyI6tugyRVx0YrGhQKuUJdVWXPyex7Z1zA13MNGsnzJ6aFGrfqStUYZT08F
iKHt/+aYa/z1u8cQgl88Xuci2yCE5uODadY1j0JSsI5Y0L/6P7TJylgdXP8ixhnh
AlZx0nrvUrPze4DKUmPVUM1bZvZDLTqEmNpQpVlnUOsgHrIqwAPfnzyLJYBOl02U
0txzUNnNI4f5MJkPRmmMNK8kJ4+qEReqbT9qOmuOFPDB3LHt0vUMx0xp0+7EQwIe
+XGbAgMBAAGjUzBRMB0GA1UdDgQWBBSFTz8+Yk9/MWymD8+AY9ERr0p84DAfBgNV
HSMEGDAWgBSFTz8+Yk9/MWymD8+AY9ERr0p84DAPBgNVHRMBAf8EBTADAQH/MA0G
CSqGSIb3DQEBCwUAA4IBAQA34tizyIg2dbEVMXvl6uF5MLAeJC/hkORMxuI/ktRf
WMsdvLiLhua6zujs00hoRY+YbX3cY1r1xE1nBHxrii0H/K8Zco1N4UVj2G3PfDxz
NlA23/A78ip+COEJzTWgmfU7AYtVnbuf0ILSRWlnUsjPAaDdl45jddoNvaqsLyhh
Vv0auIE/LWNhjWwMx/Yzn6WzrdTYtrUcndIhT+5bUIiUwROaew7IZoapGeHgzXtm
lSRSrKB/yvQ64ydSJNsVuYLrItj3Ssa0zEv88z2nfeKXGxAFjp0+ZJol4282ojDk
QIKilyxeLMqBPzWB/uGHDmBpAJuZUAmVqkGbjoXEs6ns
-----END CERTIFICATE-----''
  ];

}
