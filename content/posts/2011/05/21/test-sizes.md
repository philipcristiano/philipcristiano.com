---
title: Test Sizes
id: 2011/05/21/test-sizes
date: 2011-05-21
tags:
- testing
---
At AWeber we tend to write tests. A lot of them. I spend more time writing
tests then features. My belief is that if a line of code isn't tested it wasn't
important enough to write in the first place. You won't know when it breaks and
now you're delivering broken software.

Testing isn't covered much in school. If your projects are only 2 weeks long
and disappear after you've handed them in, testing doesn't prove it's worth.
When tests are mentioned it's never anything practical, never how to test
certain features, what parts are even worth testing?

My current project has 3 sets of tests, unit, integration, and acceptance
tests. [Google has small, medium, and
large](http://googletesting.blogspot.com/2011/03/how-google-tests-software-part-five.html)
tests which roughly correspond to what we write.

## Acceptance Tests ##
These are written first to tell us what we want from a feature. Usually these
are structure as interaction stories of the [Cucumber](http://cukes.info/)
variety.

    {% highlight bash %}
    When a customer has a list of subscribers
    And sends a message to the list
    The subscribers receive the message
    {% endhighlight %}

A common example, definitely a feature you want working. The tests are a little
more complicated than that, including assertions to make sure certain steps
execute as anticipated.

## Integration tests ##
Integration tests started as a need to test various states of our database and
queuing systems. They generally involve testing components to make sure they
behave when everything isn't perfect.

What happens when a worker dies in the middle of a job?

Can another worker pick up the job immediately or does it require human
intervention?

These stories enumerate the states our models can occupy. When an event comes
in from the queue it may be the first, a duplicate, or a re-fired event from a
failed worker. A simplified case for sending an email that can be either :

    {% highlight bash %}
    New
    Trying to send
    Sending
    Sent
    {% endhighlight %}

Our tests classes would cover the cases:

    {% highlight bash %}
    When sending a new email
    When sending an email that is trying to send
    When sending an email that is sending
    When sending a sent email
    {% endhighlight %}

Once we have the tests we can figure out which states are possible to recover
from. These cases are much more difficult to cover in acceptance tests. They
would require excessive test setup and extensive knowledge of our system.

## Unit tests ##
We write unit tests to verify our implementation. This means mocking out as
much as possible and isolating individual objects and functions. We use
[Dingus](https://github.com/garybernhardt/dingus) as our mocking library.  At
this point the feature is well defined and important test cases are covered, we
can focus on how we want to solve them.

    {% highlight bash %}
    When sending an email
    If email is New
    Generate and send an email

    When sending an email
    If email is Trying to send, Sending, or Sent
    Do not try and send the email
    {% endhighlight %}

With tests of each size we gain greater confidence that our code is working and
you can use them in a month when you forget how or why things were done this
way.
