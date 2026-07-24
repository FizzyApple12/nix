let
  fizzyapple12-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQD/shgJkC0oNWxPzuNtcHRVEEBogZ9btVyoElEJMJm fizzyapple12@FizzyApple12-PC";
  fizzyapple12-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJCSwxmRvJpmHG0JZjWaFJDKxXZTGGvAs/NrVZfUwwM fizzyapple12@fizzy-laptop";
  fizzyapple12-nas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEapKYXMBZc+lLy7lsYy3E+4jfSL6ScppEKM4LuJqPc3 fizzyapple12@fizzy-nas";
  fizzyapple12-nginx-reverse-proxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7j6pEbZ1kiS8bJD1nShCaOY1c+YkD6tD6Ugr+1SDiv fizzyapple12@ip-172-31-18-248.ec2.internal";
  fizzyapple12-hydra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPLS5l1cKACH+DNwzRJUaABNpU1ALoUh0KHaJwLNY76 fizzyapple12@hydra";
  fizzyapple12-nix-builder-1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjqnfJ1dxPalughN/ucRPm75gJdYJk4Mss5ggF8PE0U fizzyapple12@nix-builder-1";
  fizzyapple12-nix-builder-2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfR3YdJK0AQak330jFU5roeNsBn6+nISGzgYUi4xI4U fizzyapple12@nix-builder-2";
  users = [fizzyapple12-desktop fizzyapple12-laptop fizzyapple12-nas fizzyapple12-nginx-reverse-proxy fizzyapple12-hydra fizzyapple12-nix-builder-1 fizzyapple12-nix-builder-2];

  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQD/shgJkC0oNWxPzuNtcHRVEEBogZ9btVyoElEJMJm";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJCSwxmRvJpmHG0JZjWaFJDKxXZTGGvAs/NrVZfUwwM";
  nas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHn6Ee1OVJB1iEn61epRSCJPO9Rxsd90ydu1kVLw7wzL";
  nginx-reverse-proxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7j6pEbZ1kiS8bJD1nShCaOY1c+YkD6tD6Ugr+1SDiv";
  hydra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0T1oIz1NSRFObv1dcLzI2S15ZGcO3uspYn7g8NWbBe";
  nix-builder-1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtAN6YOHIK2ODfBLN8NVUKV8Boq2aw4xi0jt35EVvqs";
  nix-builder-2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINI4FnwXCGejKjX8hMRDHTPgQFKkzm2UlkMy50gGBnf0";
  systems = [desktop laptop nas nginx-reverse-proxy hydra nix-builder-1 nix-builder-2];
in {
  "secrets/age-files/hydraOIDC.age".publicKeys = users ++ systems;
  "secrets/age-files/packageSigningKey.age".publicKeys = users ++ systems;
  "secrets/age-files/authentik-env.age".publicKeys = users ++ systems;
  "secrets/age-files/authentik-ldap-env.age".publicKeys = users ++ systems;
  "secrets/age-files/copyparty-password-fizzyapple12.age".publicKeys = users ++ systems;
  "secrets/age-files/radicale-secret.age".publicKeys = users ++ systems;
  "secrets/age-files/soulseek-env.age".publicKeys = users ++ systems;
  "secrets/age-files/service-email-password.age".publicKeys = users ++ systems;
}
