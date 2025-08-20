+++
date = "2025-08-20T20:56:22.460358321Z"

[taxonomies]
tags = ["nix"]
+++

Time to upgrade `nix` on my Macbook. Ran into 

```
---- oh no! --------------------------------------------------------------------
It seems the build user _nixbld15 already exists, but with the UID
'31008'. This script can't really handle that right
now, so I'm going to give up.
```

during the install. I just ran through the users deleting them to let the installer figure it out afterwards

`sudo /usr/bin/dscl . -delete /Users/_nixbld15`

