{

  description = "chernobyl flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }: let
      system = "x86_64-linux";
  in {

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {

        pkgs = import nixpkgs {
	  config.allowUnfree = true;
          inherit system;
	};

        inherit system;
        
	modules = [ 
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.cmikol = import ./home.nix;
	  }
	  ./configuration.nix
	];
      
      };
    };
  };

}
