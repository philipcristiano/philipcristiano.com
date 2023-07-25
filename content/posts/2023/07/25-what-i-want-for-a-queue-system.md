+++
title      = "What I want for a Queue System"
date       = 2023-07-25

+++

I've been interested in queue systems since first learning about and using
RabbitMQ in ... 2009 (woah... it's been a minute). What I've learned through
most of this is that:

* People won't care as much as me
* You can't make people care
* If they don't care then it's even easier to make mistakes.

Redis is quite popular as a queue system and I've joined multiple
companies/teams where Redis and [Python-RQ](https://python-rq.org/) were used
for async tasks. Redis is wonderful and is a great solution to many problems
(including async tasks!) but in the cases I have seen, it's been mostly an
incomplete, improper solution.

Google Pub/Sub is pretty wonderful generally and the pattern I love most is
combining Pub/Sub and Cloud Run for HTTP delivery of events. There are some
limitations with this pattern but I love most of all the removal of
many problems developers can cause.

Event -> HTTP -> Service makes handling events much easier.

* It's difficult to run tasks for hours from a single HTTP request
* Handling of events requires little knowledge of a particular library
* Much of the complexity doesn't need to be in the app
* Removing the complexity from the app makes it easier for more apps to use it, without lots of work

I can't run Pub/Sub and Cloud Run at my house though.

### What I want from a queue system

* HTTP and/or GRPC submission of events to the queue system
* HTTP and/or GRPC push to a service
* Possible to run in a home environment, but not the-worst-idea in a larger environment
* Back-pressure. When too many events are in the system the publishing will slow down.
* Easy to run and not worry about it
* Small idle footprint in memory/CPU
* Horizontal scalability. If it's ever used in production somewhere, adding capacity should be easy.

### What I don't need from a queue system

* Super high throughput. 10k events per second is wonderful... but if it can do 100 and scales out, I'm not too worried.
* Perfect durability. I'll assume that at some point data might be lost and those outliers are OK.
* Perfect deliverability. I normally add end-to-end checks for data that a dropped event will only cause a delay, not a consistency problem.


### What to do about it

I haven't found exactly what I'm looking for in other systems. Since I'm mostly
scratching a self-hosting itch at the moment I'm looking to throw together a
sample system to solve my problem, never expecting it to go beyond that
(although maybe it will be useful for someone else?)

As I learn Rust, connecting [Axum](https://docs.rs/axum/latest/axum/), [Rust
channels](https://doc.rust-lang.org/rust-by-example/std_misc/channels.html) and
[Reqwest](https://docs.rs/reqwest/latest/reqwest/) should get me pretty far.

And the real goal here is to use a simple enough system similar to what I'd
recommend for production use cases with cloud services (and not my homegrown
thing).

