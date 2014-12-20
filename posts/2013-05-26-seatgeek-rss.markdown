<!---
layout: post
title: SeatGeek RSS
tags:
- seatgeek
- rss
- erlang
-->

I've setup an [RSS feed for local
concerts](http://seatgeekrss.philipcristiano.com) powered by
[SeatGeek](http://seatgeek.com). We (at SeatGeek) don't have one built-in but
we do have an [API](http://platform.seatgeek.com). The page isn't pretty but I
find it useful for finding any events I may want to go to. With tagging in
[NewsBlur](http://newsblur.com) I can filter events more easily.

I built this with Erlang as a way to test out the language. There isn't really
a direct need for high concurrency but it was a good chance to give it a try.
I've learned that I really like Erlang, it's rather terse and has constructs
built into OTP that make writing software a joy. At some point I need to tackle
using releases, but I'm not there yet.

When I spend more time on the RSS feed I'll eventually include affiliate links.
It takes a lot of traffic to make money with affiliates especially at most
concert prices. But maybe it will be an incentive for me to turn this into
something even more useful.
