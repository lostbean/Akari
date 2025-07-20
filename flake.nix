{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";
    mcphub.url = "github:ravitemer/mcp-hub";

  };

  outputs =
    {
      self,
      nixvim,
      flake-utils,
      nixpkgs,
      mcphub-nvim,
      mcphub,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        mcphub-nvim-overlay = final: prev: {
          mcphub = mcphub.packages.${prev.stdenv.hostPlatform.system}.default;
          mcphub-nvim = mcphub-nvim.packages.${prev.stdenv.hostPlatform.system}.default;
        };

        nixvimLib = nixvim.lib.${system};
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            mcphub-nvim-overlay
          ];
        };

        nixvim' = nixvim.legacyPackages.${system};

        nixvimModule = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            inherit inputs self;
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
