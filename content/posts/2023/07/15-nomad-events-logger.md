+++
title      = "Nomad Events Logger"
date       = 2023-07-15

+++

As part of learning Rust I built a tool to read events from the [Nomad Events
API](https://developer.hashicorp.com/nomad/tutorials/integrate-nomad/event-stream)
and log them to stdout. This allows an easy, low-resource way to pull Nomad
cluster events into your log processing stream.

Low-resource as in ~4MB of memory for the Docker container!

[Nomad Events Logger](https://github.com/philipcristiano/nomad-events-logger)
is deployable as a Docker image, and if I get around to it, a native binary as
well. At the moment I run ~everything in Docker in my Nomad cluster so let me
know if you want other formats.


