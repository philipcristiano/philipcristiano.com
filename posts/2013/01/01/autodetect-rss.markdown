<!---
.. layout: post
.. title: Autodetecting Your RSS Feed in the Browser
.. tags:
.. - syndication
.. - rss
-->
I noticed recently that my site didn't have the ![Syndication
Icon](/images/posts/autodetecting_rss/feed-icon-28x28.png) icon anymore. I'm
not sure when I lost it but to add it back I just added the `link` field that
lets browsers know where my Atom feed is. Simple enough to add `<link
type="application/atom+xml" rel="alternate" href="/atom.xml"/>` to the `head`
of the page.
