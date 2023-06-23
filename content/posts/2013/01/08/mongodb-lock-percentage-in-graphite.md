---
layout: post
title: MongoDB Lock Percentage in Graphite
date: 2013-01-08
tags:
- mongodb
- graphite
- diamond
---
While investigating our MongoDB lock ratio I was asking around to see what
common lock percentages were among those who I know use MongoDB. I discovered
that despite having similar setups to what we are using that they didn't know
how to get the lock percentage from Graphite.

Using [Diamond](https://github.com/brightcoveos/diamond) you can easily get all
of the [MongoDB server
status](http://docs.mongodb.org/manual/reference/server-status/) metrics into
Graphite but the `globalLock.ratio` is a bit misleading in that it is based on
the total uptime of Mongo, which could be a while, and not on recent usage
patterns. And in 2.2 it disappears anyway!

The metrics that are included though that help are `globalLock.totalTime` and
`globalLock.lockTime` which can be used to find the lock ratio/percentage over
whatever sampling period you use.

The percentage winds up being
`scale(divideSeries(derivative(servers.MONGOHOSTNAME.MongoDBCollector.globalLock.lockTime),derivative(servers.MONGOHOSTNAME.MongoDBCollector.globalLock.totalTime)),100)`.
You can remove the `scale` function to get the ratio. This doesn't work with
globbing in Graphite though. You can scale the `lockTime` though to be able to
get a globbable lock ratio for all of your Mongo servers, the exact value will
depend on the sampling period.
