<!---
layout: post
title: Brightcove's Diamond and Contributing to Projects
tags:
- brightcove
- diamond
- ganglia
- github
- mongodb
- nagios
- rabbitmq
-->

I have spent a significant amount of time recently looking into monitoring and
metrics collection. At work we have [Nagios](http://www.nagios.org/) and
[Cacti](http://www.cacti.net/) currently and are looking at other options.
After setting up Ganglia we decided to give
[Graphite](http://graphite.wikidot.com) a try.  There is a [script to send data
from Ganglia to
Graphite](https://github.com/ganglia/ganglia_contrib/blob/master/graphite_integration/ganglia_graphite.rb)
although the whole system gets to be more complex than I'd like. The chain winds
up being: monitored server -> Ganglia -> Ganglia parser -> Graphite.

Looking at the Graphite Tools page I learned about
[Diamond](https://github.com/BrightcoveOS/Diamond) which can collect metrics
using a Python agent and send them directly to Graphite. It has some very
useful collectors already and the big benefit, makes it very easy to add a new
collector!

In about an hour I was able to make a collector for
[MongoDB](http://www.mongodb.org) and submit a pull request. The changeset was
accepted making it my first contribution to an existing open-source project! I
plan on creating more collectors for software that we are using as work. Next
up is likely to be [RabbitMQ](http://rabbitmq.com).

And if you haven't, try Graphite!
