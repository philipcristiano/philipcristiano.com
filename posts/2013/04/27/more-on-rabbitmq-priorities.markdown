<!---
.. layout: post
.. title: More on RabbitMQ Priorities
.. tags:
.. - rabbitmq
.. - priorities
-->

With a single process consuming from multiple queues the prefetch count
could be a good enough solution to balancing the work from each queue.

After you have [set up priorites](2013/02/18/rabbitmq-priorities.html)
with multiple queues you still need to consume from them. You could setup
separate processes for each queue or a single process that consumes from
multiple queues.

I usually set consumers to a prefetch count of 10, it works well enough
and latency isn't much of a concern. When consuming from multiple queues
setting each queue to the same prefetch count will give you a fair
distribution of work to that consumer.

What I finally took the time to try this week was changing the prefetch
counts based on priority. In my case we had 2 queues, high and low
priority. The higher priority was based on user actions and we wanted to
happen quickly. There was only 1 set of processes consuming from both
queues and had the same prefetch counts. Since the messages are sent to
the consumer ahead of time there were 20 messages for each process.
Adjusting the low priority queue to a prefetch of 2 meant that there would
be 12 items sent to the consumer, still plenty of work. These 12 items are
put into a single queue in the library, no work needed in your code, and
will give a 5/1 distribution of work in the consumer.

With the adjusted prefetch counts we are able to control which portion of
the work we wind up doing when queues start to backup. In this case you
have to sacrifice latency to do it, the higher priority queue may give
more work to a busy consumer when others could be empty. In practice for
us this did not matter, we set the prefetch on the high priority queue to
10 anyway.

This has the nice property that low priority items are still processed
while high priority items exist and will be consumed at the highest rate
as soon as the high priority items are drained. With more than 2
queues this technique may be cause more latency than you would like
but it has be working well and required no code changes. I was
planning on making a locking mechanism, and if you didn't want any low
priority work in progress while there was high priority work you would
still need to, but I don't think one will be needed anytime soon.
