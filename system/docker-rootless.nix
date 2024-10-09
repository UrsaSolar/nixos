{...}:
{
  
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      default-address-pools = [{ base = "172.17.0.0/12"; size = 24;}];
      fixed-cidr = "172.16.0.0/14";
      bip = "172.16.0.1/24";
    };
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

}
