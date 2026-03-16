{ ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = 
	''
	100.117.101.125   mess.sodops.local
	100.117.101.125   py.sodops.local	
	100.117.101.125   php.sodops.local
	100.117.101.125   html.sodops.local
	100.117.101.125   admin.sodops.local
	'';
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
  services.openssh = {
  enable = true;
  settings = {
      UseDns = false;
      ClientAliveInterval = 60;
    ClientAliveCountMax = 3;
  };};
  programs.mosh.enable = true;
  services.tailscale.enable = true;
  # Enable systemd-resolved for better DNS resolution
  services.resolved.enable = true;
}
