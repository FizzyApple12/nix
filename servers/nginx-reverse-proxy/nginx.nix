{
  # services.nginx = {
  #     enable = true;

  #     recommendedProxySettings = true;
  #     recommendedTlsSettings = true;

  #     virtualHosts."auth.fizzyapple12.com" =  {
  #       enableACME = true;
  #       forceSSL = true;
  #       locations."/" = {
  #         proxyPass = "http://127.0.0.1:12345";
  #         # proxyWebsockets = true;
  #         extraConfig =
  #           "proxy_ssl_server_name on;" +
  #           "proxy_pass_header Authorization;"
  #           ;
  #       };
  #     };
  # };

}
