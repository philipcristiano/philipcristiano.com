---
layout: post
title: Monitoring Service Health Check Duration
tags:
- haproxy
- metrics
- health checks
- graphite
---
A recent metric I've started paying attention to was the duration of the health
check for services behind [HAProxy](http://haproxy.1wt.eu). This is reported in
the admin interface CSV and can easily be added to your metric systems. This is
what a few nodes started doing yesterday:

![Check Duration](/images/posts/check_duration/check_duration.png)

This service can usually hits the 50ms range for health checks although it
started getting much worse. The service is actually written in Tornado although
has a few blocking calls that are used. Non-blocking IO should allow the health
checks to be very quick to respond as in this case it returns a static
response.

The root cause for the problem is that calls to MongoDB in a particular handler
were taking longer than before and will hold back other handlers as it is
currently a blocking operation. If the HAProxy health checks pass a threshold
it will remove the nodes from the pool, a good precaution, although in our case
can cause flickering if MongoDB takes longer than expected.

I did receive alerts thanks to alerting of per-service health checks with
[Graphite Pager](/2012/10/07/graphite-pager.html).

We are using [Diamond](https://github.com/brightcoveos/diamond) at
[SeatGeek](http://seatgeek.com) which easily collects metrics from HAProxy.
Check duration is (by default) stored at
`servers.HAPROXY-SERVER.haproxy.BACKEND.HOST-SERVER.check_duration`. The metric
we alert on is the moving median for each server regardless of the HAProxy
server
`aliasByNode(movingMedian(groupByNode(servers.*.haproxy.*.*.check_duration,3,"averageSeries"),10),0)`.
