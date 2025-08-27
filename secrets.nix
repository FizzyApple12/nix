let
  publicKeys = let
      pkgs = import <nixpkgs> {};
      authorizedKeys = pkgs.fetchurl {
        url = "https://github.com/fizzyapple12.keys";
        sha256 = "sha256-n8CVlzwDy+wBA+3fwWQuKBNL69tIcxyaSiNCbgoRnuQ=";
      };
    in pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
in
{
  "secrets/age-files/cfAPIToken.age".publicKeys = publicKeys;
}
