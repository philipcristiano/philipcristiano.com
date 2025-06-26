+++
date = "2025-06-26T14:21:03.700254119Z"

[taxonomies]
tags = ["git", "nix"]

[extra]
in_like_of = "https://github.com/NixOS/nixpkgs/issues/355486#issuecomment-2488329223"
+++

Finally fixing my nix-based dev env on MacOS. I was getting `error: tool 'git' not found` when in a dev env. 

```
sudo xcode-select --reset
sudo xcode-select --switch /Library/Developer/CommandLineTools
```

wound up fixing it
