<!---
layout: post
title: Graphite Pager - An Easy Way to Send Alerts From Graphite
tags:
- metrics
- graphite
- monitoring
- graphite pager
-->
I've started working on a project [making it easy to send alerts from
Graphite](http://github.com/philipcristiano/graphite-pager). Previously at
AWeber we had this problem as well but used Nagios (not that easy) which
wasn't a great experience. Given that [PagerDuty](http://pagerduty) can
handle the notification part (Yay APIs!) all that was left was reading
Graphite's rawData output and triggering an alert.

Right now I'm testing it at [SeatGeek](http://seatgeek.com) running it on
Heroku, the [example of how to set up Graphite Pager on
Heroku](https://github.com/philipcristiano/graphite-pager-heroku-example) is
small and straightforward. It has already helped detect a few problems before
our other monitoring tools and (eventually) can alert on actual business
metrics!

The alert format looks like:

<script type="text/javascript" src="https://gist.github.com/3850147.js?file=alerts.yml"> </script>

Pretty Simple. It supports globbing with unique alerts for each metric.
Graphite Pager can't determine a disappearing host from the glob, maybe in the
future, but will set the alert for all metrics returned.
