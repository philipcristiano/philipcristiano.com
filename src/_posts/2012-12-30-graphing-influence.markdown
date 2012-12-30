---
layout: post
title: Graphing Influence
---
I just pushed a Python package for
[Klout-to-Graphite](http://pypi.python.org/pypi/klout-to-graphite/) that will
easily allow you to graph your [Klout](http://klout.com) within Graphite.

This started with a few minutes after lunch at [SeatGeek](http://seatgeek.com)
where we were checking various Klout scores. Since I tend to graph...
everything... I quickly setup a cron script to start collecting the metrics for
Graphite.

To run it:

<script type="text/javascript" src="https://gist.github.com/4415737.js"> </script>

Ideally this is run in cron, we use 30 minutes. Over the course of 2 weeks
there is already a few rank changes and large jumps due to adding new social
networks to Klout.

![14 Days of Kout](/images/posts/graphing_influence/14_days_of_klout.png)
