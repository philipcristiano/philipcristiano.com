<!---
layout: post
title: Example Tornado AMQP Client with Pika
tags:
- AMQP
- RabbitMQ
- Pika
- Tornado
--->
I've used AMQP for a couple of years now but never used
[Pika](http://pika.readthedocs.org/en/latest/) in production. Recently I've
been using [Haigha](https://github.com/agoragames/haigha) in my [AMQP
Dispatcher](http://github.com/philipcristiano/amqp-dispatcher) project but
needed a client for Tornado, which Pika supports. There is an example in the
Pika docs of using the Tornado Connection but it doesn't provide as usable an
interface as I'd like.

I wrote an client for internal use that handles the conditions I needed by
default (including callbacks with the result of RabbitMQ publish confirmations)
and after talking with a [previous coworker](https://twitter.com/bkjones) put
it into a gist.

It doesn't handle some things (like publish a content type with the encoded
json) and could have some better names but it may be of use to more people.

<script src="https://gist.github.com/4627474.js"> </script>
