{ pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mohamed = import ./home-manager/home.nix;
    extraSpecialArgs = { };
    backupFileExtension =
      "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" { } "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";
  };
}