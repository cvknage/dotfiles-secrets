{
  description = "SOPS secrets flake for dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "aarch64-darwin"];
    mkSopsConfig = keyFile: secrets: {
      sops = {
        defaultSopsFile = ./secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age = {
          inherit keyFile;
          generateKey = true;
        };
        inherit secrets;
      };
    };
  in {
    nixosModules.default = {
      sops-nix,
      keyFile,
      secrets,
      ...
    }: {
      imports = [
        sops-nix.nixosModules.sops
        (mkSopsConfig keyFile secrets)
      ];
    };

    homeManagerModules.default = {
      sops-nix,
      keyFile,
      secrets,
      ...
    }: {
      imports = [
        sops-nix.homeManagerModules.sops
        (mkSopsConfig keyFile secrets)
      ];
    };

    devShells = nixpkgs.lib.genAttrs systems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.sops
          pkgs.age
        ];
      };
    });
  };
}
