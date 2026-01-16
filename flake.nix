{
  description = "Sodiqning NixOS va Home Manager konfiguratsiyasi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, antigravity-nix, ... }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # NixOS sistema konfiguratsiyasi
      nixosConfigurations.sodiq = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          
          # Home Manager ni NixOS module sifatida qo'shish
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sodiq = import ./home.nix;
            
            # Antigravity ni home-manager orqali qo'shish
            home-manager.extraSpecialArgs = {
              inherit antigravity-nix system;
            };
          }
        ];
      };

      # Home Manager standalone konfiguratsiyasi (ixtiyoriy)
      homeConfigurations.sodiq = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            home.packages = [
              antigravity-nix.packages.${system}.default
            ];
          }
        ];
      };
    };
}