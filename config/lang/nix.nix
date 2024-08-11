{ pkgs, ... }:
let
  flake = "/home/spector/nixos-config";
in
{
  plugins = {
    nix.enable = true;
    hmts.enable = true;
    nix-develop.enable = true;

    conform-nvim = {
      formattersByFt = {
        nix = [ "nixfmt-rfc-style" ];
      };

      formatters = {
        nixfmt-rfc-style = {
          command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        };
      };
    };

    lint = {
      lintersByFt = {
        nix = [ "statix" ];
      };

      linters = {
        statix = {
          cmd = "${pkgs.statix}/bin/statix";
        };
      };
    };

    lsp.servers.nixd = {
      enable = true;
      extraOptions.settings = {
        nixd = {
          nixpkgs.expr = ''import (buitins.getFlake "${flake}").inputs.nixpkgs { }'';
          options.nixos.expr = ''(builtins.getFlake "${flake}").nixosConfigurations.alfhiem.options'';
          flake_parts.expr = ''let flake = builtins.getFlake ("${flake}"); in flake.debug.options // flake.currentSystem.options'';
        };
      };
    };
  };

  extraConfigVim = ''
    au BufRead,BufNewFile flake.lock setf json
  '';
}
