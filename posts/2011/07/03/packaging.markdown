<!---
.. layout: post
.. title: Packaging
.. tags:
.. - packaging
.. - projects
.. - supervisor
.. - plug
-->

Roughly 2 weeks ago I started [Plug](https://github.com/philipcristiano/plug)
which aims to create a package format for Python daemons. The project started
after seeing how [Supervisor](http://supervisord.org/) handles 150+ processes.

A current project at work can easily have many daemon processes with differing
number of running instances that may need to be adjusted frequently. Deploying
with Supervisor can be a problem given the amount of time Supervisor would take
to start/stop processes.

Plug installs each package into a virtualenv then uses
[runit](http://smarden.org/runit/) to manage each daemon instance.

I have a prototype version working now with a packaged version to come in the
next few weeks after giving it more testing.

The biggest issue is after watching [To Package or Not to
Package](http://dev2ops.org/blog/2011/7/2/devops-days-mountain-view-2011-to-package-or-not-to-package.html)
I am falling in more of the "to package" crowd and despite Plug being a
packaging solution smells a bit too much of NIH.
