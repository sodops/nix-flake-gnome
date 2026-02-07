{
  description = "Sodiqning NixOS va Home Manager konfiguratsiyasi";

  inputs = {
    # Nixpkgs - nixos-25.11 stabil versiyasi (eng so'nggi yangilanishlar bilan)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity.url = "github:jacopone/antigravity-nix";
  };

  # 'inputs@' qo'shish orqali barcha inputlarni bitta o'zgaruvchiga olamiz
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.sodiq = nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Tizim modullariga 'inputs'ni uzatish
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sodiq = import ./home.nix;
            
            # Home Manager modullariga barcha inputlarni uzatish
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
