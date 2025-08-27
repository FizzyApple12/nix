let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQD/shgJkC0oNWxPzuNtcHRVEEBogZ9btVyoElEJMJm fizzyapple12@FizzyApple12-PC";
  nginx-reverse-proxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7j6pEbZ1kiS8bJD1nShCaOY1c+YkD6tD6Ugr+1SDiv fizzyapple12@ip-172-31-18-248.ec2.internal";
  systems = [ desktop nginx-reverse-proxy ];
in
{
  "secrets/age-files/cfAPIToken.age".publicKeys = systems;
}
