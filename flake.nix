{
  description = "A python wrapper around GetPocket API V3.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    {
      devShell = self.defaultPackage;
      defaultPackage.x86_64-linux =
        with import nixpkgs { system = "x86_64-linux"; };
        pkgs.python3Packages.buildPythonPackage rec {
          pname = "pocket-api";
          version = "0.1.5";
          src = (
            pkgs.python3Packages.fetchPypi {
              inherit pname version;
              format = "wheel";
            }
          );
          propagatedBuildInputs = with pkgs.python3Packages; [ requests ];
        };
    };
}
