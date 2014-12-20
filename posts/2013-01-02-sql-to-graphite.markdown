<!---
layout: post
title: SQL-to-Graphite
tags:
- graphite
- sql-to-graphite
- python
-->
I released a package
[SQL-to-Graphite](http://github.com/philipcristiano/sql-to-graphite) that aims
to easily save the results of SQL queries into Graphite.

We use this and similar scripts (I'm going to move over to using this) at work
in order to collect global metrics about our systems. I typically count any table
that has a `status` column and the average/max age of any records that should
be updated periodically.

I made this package once I hit the second repository where I would have to
write a script to do this. It should be compatible with any database supported
by SQLAlchemy.

After installing (`pip install sql-to-graphite`) you can run the `sql-to-graphite` command.

<script src="https://gist.github.com/4440057.js"> </script>

With a file like:

<script src="https://gist.github.com/4440059.js"> </script>

And start getting metrics into Graphite!
