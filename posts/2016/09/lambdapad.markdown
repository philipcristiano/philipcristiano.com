<!--
.. title: LambdaPad
.. slug: lambdapad
.. date: 2016-09-09 19:51:52 UTC
.. tags: lambdapad, erlang, contentful
.. link:
.. description:
.. type: text
-->

I recently came across a static site generator written in Erlang called
[LambdaPad](https://github.com/gar1t/lambdapad). I looked around a bit while
trying to find a static site generator that would work with
[Contentful](http://contentful.com) that I would enjoy working with. Most
static site generators expect to source documents from the filesystem but
LambdaPad allows any source of data you can write in Erlang!

Contentful is a CMS with an API and is free for small use cases. It is easier
to use their API as a source then to have other people edit a Git repository in
my [expected case](http://vsl.philipcristiano.com/).


My Github has a
[branch](https://github.com/philipcristiano/lambdapad/tree/contentful) that can
source Contentful entries and provide them to templates. After adding some
documentation, examples, and handling Contentful pagination it should be ready
for a PR.

... another example of me spending more time on infrastructure instead of a
user-facing project which began this tangent!.
