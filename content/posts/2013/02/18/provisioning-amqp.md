---
layout: post
title: Provisioning AMQP
date: 2013-02-18
tags:
- amqp
- provisioning
---
AMQP clients will allow you to declare your exchanges, queues, and bindings at
the consumer level but that can cause problems as you use it more. You may get
to the point that you will have to grep for all the `declare` methods in your
code or run into problems trying to migrate to a new broker.

An alternative is to have consumers and producers take only the name of a queue
or exchange and handle the rest outside of the application. This allows you to
see and change in one place the configuration for all of your applications.
When you need to provision a new broker it is done in a few seconds instead
having to migrate some consumers, then all producers, then the rest of the
consumers.

I've started writing and using [Declare
AMQP](https://github.com/philipcristiano/declare-amqp) so that I can provision
everything within Chef. It only supports the features I'm using but is very
simple.

The migration is now much simpler as provisioning the server once is enough
to make it ready for all applications. When I need to change exchanges or
bindings I don't have to update any code. There is still the need to know
which applications publish which routing key, but not a huge concern.

This has helped out as well configuring queues with specific priorities for the same
type of tasks. Each application can be started with a queue to listen to and the
configuration for both the broker and applications remains in one place.
