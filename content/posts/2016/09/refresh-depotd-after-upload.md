---
title: Refreshing pkg.depotd After Package Upload
id: 2016/09/16/refresh-depotd-after-upload
date: 2016-09-16
tags: omnios, depotd, pkgsend, pkgrepo
link:
description:
type: text

---
After uploading a package to an OmniOS package repository I was unable to find
the package by searching. The package could be installed and local searching
would find it, but the depotd server didn't know how to find the package when
searching. Restarting `pkg/server` would work around the issue but having to do
that after each publish would get annoying.

There is a command [pkgrepo](http://docs.oracle.com/cd/E36784_01/html/E36870/pkgrepo-1.html) that will refresh the search index remotely!

Running

```
pkgrepo refresh -s PKGSRVR
```

is enough to reload the search index.
