<!--
.. title: Testing Riak Core VNodes
.. slug: testing-riak-core-vnodes
.. date: 2014-12-23 16:55:49 UTC
.. tags: riak_core
.. link:
.. description:
.. type: text
-->

I've started trying to test [ETSDB](http://github.com/philipcristiano/etsdb)
with Common Test and found that it wasn't terribly straightforward to test the
Riak Core vnode. The vnode is managed by a Riak Core gen_fsm and isn't a
built-in OTP behavior.

I wanted to include the Riak Core gen_fsm to make sure that I integrated it
properly. First you want to spin up the `riak_core_vnode` with your vnode
implementation and save the config in the Pid.

<script src="https://gist.github.com/philipcristiano/9f16cb30196383580e13.js"> </script>

Similarly to tear it down you should send a message to stop the FSM. This requires a
tear down call and adding a handler in your vnode to return a `stop`.

<script src="https://gist.github.com/philipcristiano/350ebbf12936ce46affd.js"> </script>

That includes the `send_command` which is a variation from the Riak Core
source. It will handle sending the message in a way that can get the response
sent back to the sending process. Riak Core does some mucking around to deal
with running with the full application.

<script src="https://gist.github.com/philipcristiano/72b6f9668f93c668c583.js"> </script>

Now you can call `send_command` with the Pid of the FSM and with the ref
returned can pull that messages out of the mailbox!
