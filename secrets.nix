let
  publicKeys =  let
      authorizedKeys = import <nix/fetchUrl> {
        url = "https://github.com/fizzyapple12.keys";
        sha256 = "sha256-kHwxnznq7LHRoV1KCWhdkVwW65+AQzDTwMxd9a2S4zk=";
      };
    in import <nix/lib/splitString> "\n" (builtins.readFile authorizedKeys);
in
{
  "secrets/age-files/cfAPIToken.age".publicKeys = publicKeys;
}
