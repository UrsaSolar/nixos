{ config, ... }:
{

  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = 3031;
        grpc_listen_port = 0;
      };
      positions.filename = "/tmp/positions.yaml";
      clients = [{ url = "https://loki.proxy.ursa.solar/loki/api/v1/push";}]; 
      scrape_configs = [{
        job_name = "journal";
        journal = {
          max_age = "12h";
          labels = {
            job = "systemd-journal";
            host = "${config.networking.hostName}";
          };
        };
        relabel_configs = [
          { source_labels = [ "__journal__systemd_unit" ]; target_label = "unit"; }
          { source_labels = [ "__journal__hostname" ]; target_label = "hostname"; }
          { source_labels = [ "__journal_container_name" ]; target_label = "docker_container_name"; }
          { source_labels = [ "__journal_container_id" ]; target_label = "docker_container_id"; }
        ];
      }];
    };
  };


}
