title: Error Publishing to pkg.depotd
id: 2016/09/error-publishing-to-pkgdepotd
date: 2016-09-15 20:04:03 UTC
tags: omnios, pkgsend, depotd
link:
description:
type: text

When publishing to an IPS depotd server you may see the line

```
pkgsend: Publisher 'default' has no repositories that support the 'open/0' operation.
```

If the depotd server will show you a web page but publishing does not work with
pkgsend you may have the server setup in read only mode. `svccfg` will allow you to change the property with

```
svccfg -s pkg/server setprop pkg/readonly = false
```

Don't do this to a server on the internet though, placing an HTTP server in
front of depotd will allow you to add authentication. This is otherwise
insecure!
