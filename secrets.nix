{
  pkgs,
  ...
}:
let
  publicKeys = let
      authorizedKeys = pkgs.fetchurl {
        url = "https://github.com/fizzyapple12.keys";
        sha256 = "sha256-kHwxnznq7LHRoV1KCWhdkVwW65+AQzDTwMxd9a2S4zk=";
      };
    in pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
in
{
  "secrets/age-files/cfAPIToken.age".publicKeys = publicKeys;
}
