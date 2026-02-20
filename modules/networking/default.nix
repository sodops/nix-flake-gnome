{ ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
    allowedTCPPorts = [ 
     9090 # Prometheus
     3000 # Grafana
     3100 # Loki
     9093 # AlertManager
     9100 # NodeExporter
     9115 # Blackbox
     8181 # cAdvisor
    ];
   trustedInterfaces = [ "docker0" "docker_gwbridge" ];
  };

  # Enable systemd-resolved for better DNS resolution
  services.resolved.enable = true;
}
