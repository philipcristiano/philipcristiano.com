<!---
.. layout: post
.. title: Branch Coverage with Nose
.. tags:
.. - testing
.. - nose
.. - python
-->

Since I heard about the addition of branch coverage tracking for
[Coverage](http://nedbatchelder.com/code/coverage/) I've wanted to give it a
try. Originally it required a beta release which somehow I never got working.

Once it was in a normal release I somehow forgot about it. There is still no
commandline argument to turn it on when using
[Nose](http://somethingaboutorange.com/mrl/projects/nose/). You can however use
the _.coveragerc_ file to enable it.

In _.coveragerc_ simply put

{% highlight bash %}
    [run]
    branch = True
{% endhighlight %}

And next time you run Nose with coverage you'll have branch coverage too! I was
finally reminded about this when coming across the [Test Coverage
Analysis](http://lautaportti.wordpress.com/2011/05/07/test-coverage-analysis/)
post by [Kai Lautaportti](http://lautaportti.wordpress.com/).
