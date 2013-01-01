---
layout: post
title: Resque Metrics with StatsD
tags:
- ruby
- resque
- statsd
- metrics
---
A recent task of mine was to add some metric collection to a Rails application
at [SeatGeek](http://seatgeek.com). One of the main components (and critical if
there was a problem) is the set of [Resque](https://github.com/defunkt/resque)
background workers. There is actually a Resque Plugin
([abandoned](https://github.com/jamster/resque-statsd),
[maintained](https://github.com/noahhl/resque-statsd) that will collect stats.
The gem sadly is not maintained so I forked the maintained repo in order to
provide a stable source. I use the commit hash to make sure I get the version
but if the repository we used disappears that would cause problems, so a fork
solves that.[My fork](https://github.com/philipcristiano/resque-statsd) doesn't
change much except for some of the paths used for the metrics. At some point I
may clean up the README and package my first gem.
