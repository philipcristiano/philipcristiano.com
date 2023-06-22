---
id         : 2021/04/more-nixos-declarative-containers
title      : More Declarative Containers with NixOS
date       : 2021-04-28
blurb      : NixOS Docker for later versions

---
In newer versions of NixOS it's possible to use Docker directly in your [`/etc/nixos/configuration.nix`](https://nixos.wiki/wiki/NixOS_Containers)!

Example from that page:

```
 { config, pkgs, ... }:
 {
   config.docker-containers = {
     hackagecompare = {
       image = "chrissound/hackagecomparestats-webserver:latest";
       ports = ["127.0.0.1:3010:3010"];
       volumes = [
         "/root/hackagecompare/packageStatistics.json:/root/hackagecompare/packageStatistics.json"
       ];
       cmd = [
         "--base-url"
         "\"/hackagecompare\""
       ];
     };
   };
 }
```

I've moved to this format as it's a bit cleaner and simpler to use for syncing container images than `rkt` wound up being.
