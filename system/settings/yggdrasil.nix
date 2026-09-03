{ ... }:
{
  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    settings = {
      Peers = [
        "tls://ygg-msk-1.averyan.ru:8362"
        "tls://ru2.cert.dev:7041"
        "tls://ygg-ru.lskd.pw:30042"
        "tls://yggno.de:18227"
        "tls://kursk.cleverfox.org:15015"
      ];
    };
  };
  networking.firewall.trustedInterfaces = [ "tun0" ];
}
