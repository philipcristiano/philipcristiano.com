---
layout: post
title: Deploying Python Without Downtime
tags:
- python
- gunicorn
- deployment
---

When you first start out deploying your application it can be easy to just run
`supervisor restart all` or `service my_app restart` to get your current
version into production. This is great when you are starting out but eventually
you will try to connect while your application is starting up and see HTTP 503s
while you application is booting up.

Eventually you might discover that Gunicorn and uWSGI can reload your
application without closing the socket so your web requests will just be
delayed a bit delayed as your application starts. This works fine as long as
your application doesn't take too long to start. Unfortunately some
applications at work can take a minute to start, too long to have connections
waiting at the socket.

The Gunicorn reloading using `kill -HUP $PID` will stop
all worker processes then start them again. The slow init for workers tends to
cause problems. uWSGI has [chain
reloading](http://uwsgi-docs.readthedocs.org/en/latest/Changelog-1.9.html#chain-reloading)
which will restart workers one at a time. I need support for Tornado which
doesn't fit well with uWSGI.

#### With a Load Balancer

A common technique is to remove a single server from the load balancer,
upgrade/restart the application, then bring it back. We are using load
balancers but it requires coordination while provisioning nodes using the HAProxy
management socket in order to schedule this. Our deploys currently deploy to
all nodes simultaneously, not one-by-one, an even larger change. It would also
be possible to fool the healthcheck by 404'ing the status page then waiting for
LBs to take the node out of the pool. That requires a bit more waiting than I
want, 2 healthcheck failures with 5 second intervals, for each server, plus
time to reintegrate the web process once the upgrade is finished.

#### Gunicorn Reload ++

Gunicorn will automatically restart failed web processes so it would be possible
to just kill each process, sleeping in between, until you get through all the child
processes. This works but if application start times change significantly we are
either waiting too long for restarts or not long enough and risking some downtime.

Since Gunicorn includes Python hooks into the application it should be possible
to write a snippet that will notify the restart process when the worker application
is ready. Gunicorn didn't have the needed hook but it was simple to [contribute
the change](https://gunicorn-docs.readthedocs.org/en/latest/configure.html?highlight=settings#post-worker-init). It requires `master` until a new release is made.

Now our restart process takes advantage of the fact that a single socket has multiple
processes accepting connections. Restarting will slightly diminish our capacity (1/N)
but we will continue to handle traffic without letting connections wait too long.

The general process for this is

  for child_pid of gunicorn-master:
    kill child_pid
    wait for app startup

My first version of this used shell and `nc` to listen on UDP for an
application startup.  This worked well although integrating our process manager
into shell was a bit more then I would like to do.

The restart script should be called with the PID of the Gunicorn master `restart.sh $PID`

<script src="https://gist.github.com/philipcristiano/5854406.js"> </script>

and works in tandem with a `post_worker_init` script that will notify the script
when the app is running.

<script src="https://gist.github.com/philipcristiano/5854424.js"> </script>

If we had this WSGI application for example:

<script src="https://gist.github.com/philipcristiano/5854532.js"> </script>

We could even do things like check the `/_status` page to verify the
application is working.

<script src="https://gist.github.com/philipcristiano/5854546.js"> </script>

Be careful with trying to run too much of your application in this healthcheck,
if for any reason your `post_worker_init` raises an error then the worker will
    exit, preventing your application from starting. This may be a problem when
    you are checking a DB connection that may go away, even if you application
    could work it won't be able to boot.

Now with our applications that take a minute to start we can do a rolling restart without taking the application down or dropping any connections!
