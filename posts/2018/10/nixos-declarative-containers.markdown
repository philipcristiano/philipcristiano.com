id         : 2018/10/nixos-declarative-containers
title      : Declarative Containers with NixOS
date       : 2018-10-11
blurb      : First attempts at a declarative Docker NixOS config

I spent some time recently attempting to setup some software on a NixOS system I have at home. It looks like declarative containers were removed in an earlier version of NixOS as they weren't quite ready for use. After [some searching](https://github.com/NixOS/nixpkgs/issues/37553) I was able to find an example with `rkt`!

Setting up a container can be as simple as adding this to your `/etc/nixos/configuration.nix`:


```
virtualisation.rkt.enable = true;

systemd.services."rkt-nginx" = {
  description = "Nginx (rkt)";
  wantedBy = [ "multi-user.target" ];
  serviceConfig = {
    Slice = "machine.slice";
    ExecStart = ''\
      ${pkgs.rkt}/bin/rkt run --insecure-options=image \
      --net=host \
      docker://nginx
    '';
    KillMode = "mixed";
    Restart = "always";
  };
};
```
