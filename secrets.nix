let
  fizzyapple12-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQD/shgJkC0oNWxPzuNtcHRVEEBogZ9btVyoElEJMJm fizzyapple12@FizzyApple12-PC";
  fizzyapple12-nginx-reverse-proxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7j6pEbZ1kiS8bJD1nShCaOY1c+YkD6tD6Ugr+1SDiv fizzyapple12@ip-172-31-18-248.ec2.internal";
  fizzyapple12-hydra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPLS5l1cKACH+DNwzRJUaABNpU1ALoUh0KHaJwLNY76 fizzyapple12@hydra";
  users = [ fizzyapple12-desktop fizzyapple12-nginx-reverse-proxy fizzyapple12-hydra ];

  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmvWcVtdJ73qfmxAbvQi2DS7K/XRISSrIqs3IKuHEQU root@FizzyApple12-PC";
  nginx-reverse-proxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWbnWJlW5chwVtcVcrpg5Do2P7ArvoxmMS4dETUzMsq root@ip-172-31-18-248.ec2.internal";
  hydra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0UW6UueGaqZPfyUyVwFJBoGC21mJyyBsH3+fUkZGIn root@hydra";
  systems = [ desktop nginx-reverse-proxy hydra ];
in
{
  "secrets/age-files/cfAPIToken.age".publicKeys = users ++ systems;
  "secrets/age-files/hydraOIDC.age".publicKeys = users ++ systems;
}
