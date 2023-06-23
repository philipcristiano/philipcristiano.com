---
layout: post
title: Prioritizing Emails with RabbitMQ
date: 2013-02-18
tags:
- rabbitmq
- priorities
---
After you move a few tasks to the background with RabbitMQ you may realize
that you eventually need to support different priorities for the same type of
tasks, sending bulk email after you send transactional email. RabbitMQ doesn't
have priorities so you wind up having to use separate queues for each priority.

You should already have a worker that can send the email, just now you need
setup RabbitMQ with priorities.

The main exchange you use, `email`, should be declared either topic or direct
and will take all of the messages you intend to send but when declared you
should include an [alternate exchange](http://www.rabbitmq.com/ae.html) of
`email-undeliverable` that is declared as a fanout exchange. Now you just
need a `default` queue bound to the `default` routing key for the `email`
exchange and also bound to `email-undeliverable`. Now every email your try
to send that doesn't have a specifically prioritized queue will be routed
to the `default` queue.

All you need now is to start your workers consuming from each queue you create.
