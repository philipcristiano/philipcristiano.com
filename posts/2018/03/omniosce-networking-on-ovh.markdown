id: 2018/03/omniosce-networking-on-ovh
title: OmniosCE Networking on OVH
slug: omniosce-networking-on-ovh
date: 2018-03-12 00:00:00 UTC
tags: omnios, omniosce, ovh, networking
link:
description:
type: text

I recently found that my DHCP leasing on OVH was unreliable. The address worked
at one point, but after a few months/reboots I found that the instance could
not longer obtain a lease. After a few attempts to release/renew, I decided to set a static IP.

The [General Administration
page](http://wiki.omniosce.org/GeneralAdministration) has general information
about setting this. The IP from your [OVH control
panel](https://ca.ovh.com/manager/) for the specific server is needed. From
that information the routing gateway can be determined.

The gateway is the same as the IP of the server with the last octet replaced
with `254`. If the IP is `10.2.3.4`, the gateway is `10.2.3.254`. To set this on the host:

```
ipadm create-addr -T static -a $SERVER_IP/32 ixgbe0/v4
route -p add default $GATEWAY_IP
```
