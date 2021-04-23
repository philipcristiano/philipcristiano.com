title: Listing All Versions of an IPS Package
slug: listing-all-versions-of-an-ips-package
id: 2018/02/08/listing-all-versions-of-an-ips-package
date: 2018-02-08
tags: omniosce, ips
link:
description:
type: text

Listing all packages (with FMRI) can be useful to see what you could install. It wasn't immediately obvious to me and couldn't easily find how to do.

```
pkg list -afv $PACKAGE
```

`-af` lists all versions, regardless of installation state

`-v` Includes the FMRI in the output

If you don't see a newer version you think should be there, try a `pkg refresh`!
