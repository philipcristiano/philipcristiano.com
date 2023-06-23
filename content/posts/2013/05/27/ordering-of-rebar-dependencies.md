---
layout: post
title: Ordering of Rebar Dependencies
date: 2013-05-27
tags:
- rebar
- lager
- erlang
---

As I am starting out with Erlang I've just added dependencies to the end of
my Rebar config and everything just kind of worked. I added each dependency
one-by-one and didn't have a problem until I cleaned out the `deps` folder
and tried to recompile. Then I ran into this error:

`src/ranch_protocol.erl:none: undefined parse transform 'lager_transform'`

I knew that it was working before and that the parse transform wasn't an issue.
Turns out the dependency ordering matters! Shouldn't be too big a surprise but
Rebar uses the list of dependencies as the ordering for compilation, not any
kind of introspection. I just had to put the Lager dependency above Ranch and
everything worked out.
