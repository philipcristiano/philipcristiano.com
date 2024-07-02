+++
+++

I think I've always had a pleasant time upgrading my NixOS boxes. For my homelab servers 

```
sudo nix-channel --add https://channels.nixos.org/nixos-24.05 nixos
sudo nixos-rebuild switch --upgrade
sudo reboot
``` 

Has "just worked". Keeping most of my lab stuff in Nomad helps with this as well as there isn't much that will change at the OS level, mostly Nomad, Consul, and Vault.  
