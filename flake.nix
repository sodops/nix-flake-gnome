{
  description = "Sodiqning NixOS va Home Manager konfiguratsiyasi";

  inputs = {
    # Nixpkgs - ma'lum bir versiyaga qulflangan (2026-01-10)
    nixpkgs.url = "github:nixos/nixpkgs/d03088749a110d52a4739348f39a63f84bb0be14"; 
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 'inputs@' qo'shish orqali barcha inputlarni bitta o'zgaruvchiga olamiz
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.sodiq = nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Tizim modullariga 'inputs'ni uzatish (bu juda muhim!)
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sodiq = import ./home.nix;
            
            # Home Manager modullariga maxsus o'zgaruvchilarni uzatish
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # standalone konfiguratsiya odatda 'nixos-rebuild' uchun shart emas,
      # lekin u ham 'inputs'dan foydalanishi kerak
      homeConfigurations.sodiq = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
          ./home.nix 
          {
            # inputs'ni module argumenti sifatida ham qo'shamiz
            _module.args = { inherit inputs; };
          }
        ];
      };
    };
}