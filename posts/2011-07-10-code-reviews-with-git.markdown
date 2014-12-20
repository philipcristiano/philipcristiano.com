<!--
layout: post
title: Code Reviews with Git
tags:
- git
- code-review
-->

A few weeks ago at work we improved our code review process by using Git more
effectively. Previously a code review happened after the topic branch was
merged into **master**. This obviously was not very effective as changes could
have broken master without a proper review and there was less incentive to
perform as careful of a review since the code was "working" already. This was
carried over from when we were using SVN until we realized we were no longer
forced to work in the dark ages.

Since we were already using Git we could easily change our workflow for a
better review process. Once a topic branch was ready for review we could push a
remote branch. Our remote branches take the form **/review/{initials}/{topic}**

To push a new remote branch:

{% highlight bash %}
    git push origin {branch name}:/review/{initials}/{branch name}
{% endhighlight %}

And then we would move the Kanban card to the review column and find someone to
review our changes.

When the code has been reviewed and any necessary changes made the reviewer
will merge them into **master**.

{% highlight bash %}
    git checkout master
    git merge --no-ff --no-commit /review/{initials}/{branch name}
    git commit -s
{% endhighlight %}

The merge command turns off fast-forward merging and commiting so when we
commit with a -s we can sign-off on the changes. This shows who reviewed the
code. We don't permit anyone to push their own changes without review although
Git doesn't prevent you from changing the committer or the sign-off.

Then finally remove the remote branch by pushing an empty branch over it and
delete your local copy of the branch.

{% highlight bash %}
    git push origin :/review/{initials}/{branch name}
    git branch -d /review/{initials}/{branch name}
{% endhighlight %}
