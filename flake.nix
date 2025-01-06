{
  description = "A nixvim configuration";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";

    # color tools
    minty = {
      url = "github:NvChad/minty";
      flake = false;
    };

    volt = {
      url = "github:NvChad/volt";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixvim,
      flake-utils,
      nixpkgs,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixvimLib = nixvim.lib.${system};
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        nixvim' = nixvim.legacyPackages.${system};

        nixvimModule = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            inherit inputs;
          } // import ./lib { inherit pkgs; };
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in
      {
        checks = {
          # Run `nix flake check` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

        # Lets you run `nix run` to start nixvim
        packages.default = nvim;

      }
    )
    // {
      overlays.default = final: prev: {
        akari = self.packages.${prev.stdenv.hostPlatform.system}.default;
      };
    };
}
