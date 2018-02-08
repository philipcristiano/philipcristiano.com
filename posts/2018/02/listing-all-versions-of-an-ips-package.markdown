<!--
.. title: Listing All Versions of an IPS Package
.. slug: listing-all-versions-of-an-ips-package
.. date: 2018-02-08 00:16:15 UTC
.. tags: omniosce, ips,
.. link:
.. description:
.. type: text
-->

Listing all packages (with FMRI) can be useful to see what you could install. It wasn't immediately obvious to me and couldn't easily find how to do.

```
pkg list -afv $PACKAGE
```

`-af` lists all versions, regardless of installation state

`-v` Includes the FMRI in the output
