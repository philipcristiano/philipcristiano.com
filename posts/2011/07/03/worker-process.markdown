<!---
.. layout: post
.. title: Worker Process
.. tags:
.. - projects
.. - worker-process
.. - python
-->
Part of a current project at work involves writing many stand-alone processes
to handle events from RabbitMQ. The worker processes are managed by Supervisor
but should gracefully handle SIGTERM and generally follow a common pattern.

The main design is splitting out how worker's should run from what they are
supposed to be doing. Extending the BaseWorker class will give a main
classmethod used to start new workers.

The BaseWorker class is split from the WorkerRunner class giving a common interface
for all workers and Unixy interaction.

You can take a look at what I have so far on the [projects page](/projects.html).
