---
layout: post
title: Graphite Pager - v0.0.6 - Links to Documentation
tags:
- graphite
- monitoring
- graphite pager
- documentation
---
I've released version v0.0.6 of [Graphite
Pager](http://github.com/philipcristiano/graphite-pager) my tool for alerting
based on Graphite metrics.

The change for this release was to add links to documentation for each alert.
Currently the format of the URL is {docs_url}/{alert name}#{alert legend name}
where the `docs_url` is specified in the YAML config and the rest is based on
the alert that is triggering.

While people at work haven't jumped to create metrics and alerts for various
things this will at least make it easier for them to know why this alert was
created and have to fix the problem. Right now I have only documented a few
alerts and will do so as existing alerts fire. If anyone needs alerts made I
will make sure the wiki page exists ahead of time.
