---
layout: post
title: Python TDD with Dingus - A Markdown Function
categories:
- testing
- dingus
- tdd
---
Here is a walk through for testing a simple function that will convert a
directory of markdown files to a directory of HTML files

It should take 2 paths, the source directory and the output directory.


# Acceptance Test #

In acceptance tests you will want to test as large a feature as possible. The
test in this case will assert that a file in the src directory is converted to
HTML in the output directory.

Since we want this to create the files on disk we will need to import os.path
for some helper functions.

{% highlight python %}
    import os.path
{% endhighlight %}

Then we import the function we plan on testing.

{% highlight python %}
    from markdown_processor import process_markdown
{% endhighlight %}

From there we can begin by creating the test class that will handle all of our
setup and our assertion.

{% highlight python %}
    class WhenRunningProcessor(object):

        @classmethod
        def setup_class(cls):
            cls.src_dir = 'src_example'
            cls.target_dir = 'target_dir'

            process_markdown(cls.src_dir, cls.target_dir)
{% endhighlight %}

This creates a class *WhenRunningProcessor* That inherits from object. Before
each test case Nose allows us to run code to setup the test. In this case we
use the @classmethod decorator and setup_class. This function will be run once
before all tests in this class. Acceptance tests will take longer to run then unit
tests and usually do not require the same level of isolation.

Then we define the src_dir and target_dir since we will be using them a few
times.

Finally we run the function we plan on testing passing in the src_dir and
target_dir.

Now we can write the acceptance test for this function

{% highlight python %}
    def should_have_html_hello_world(self):
        file_path = os.path.join(self.target_dir, 'hello_world.html')
        content = open(file_path, 'r').read()
        assert '<p>Hello World!</p>' in content
{% endhighlight %}

Our test is checking that the text '&lt;p&gt;Hello World!&lt;/p&gt;' is in a file in the
output directory. This requires some fixture data in the source directory which
is only

    Hello World!

The file_path is the our target_dir folder and the hello_world.html file. The file
is read and then an assertion checking that the test exists.

The whole test file will look like this:

{% highlight python %}
    import os.path

    from markdown_processor import process_markdown

    class WhenRunningProcessor(object):

        @classmethod
        def setup_class(cls):
            cls.src_dir = 'src_example'
            cls.target_dir = 'target_dir'

            process_markdown(cls.src_dir, cls.target_dir)

        def should_have_html_hello_world(self):
            file_path = os.path.join(self.target_dir, 'hello_world.html')
            content = open(file_path, 'r').read()
            assert '<p>Hello World!</p>' in content
{% endhighlight %}

# Unit Tests #
In our unit tests we will test how we plan to implement this functionality. The
mocking library Dingus will allow us to isolate the our function from the OS
and our other libraries. After the function is run we can test to make sure the
code works how we expected it to.

First will will import everything we need for the test

{% highlight python %}
    from dingus import Dingus, DingusTestCase

    from markdown_processor import process_markdown
    import markdown_processor as mod
{% endhighlight %}

The dingus library provides us with a Dingus class which we will use to assert
what our function is doing and the DingusTestCase will automatically isolate
our function.

As well as the function we want to test we also import the module to help us
make assertions about what goes on outside the function.

Now we can setup a base class to use for our tests. This will hold the common
elements we use for our tests.

{% highlight python %}
    class BaseProcessing(DingusTestCase(process_markdown)):

        def setup(self):
            super(BaseProcessing, self).setup()
            self.src_dir = Dingus('src_dir')
            self.target_dir = Dingus('target_dir')

            mod.os.listdir.return_value = ['hello_world.markdown']
            mod.os.path.splitext.return_value = ('hello_world', 'markdown')

            self.md = mod.markdown.Markdown()
{% endhighlight %}

Our BaseProcessing class inherits from DingusTestCase while passing in our
function. This will isolate our function and replace everything around it with
Dingus objects.  The setup method will be run before *each* test, unlike the
acceptance tests where setup_class was only run once.  We once again setup our
src_dir and target_dir but this time use Dingus objects while passing in a
helpful name. In this case the strings for our directories shouldn't be
modified but this allows you to verify any operations performed on the
arguments.

Next we set the return values of some function we plan on using. Remember
everything but our function is a Dingus which only return a new Dingus when
called.  The listdir function will return a list of entries in the directory.
In this case we just want to return a list with 1 file. We will need to get the
filename without an extension so we will set the return_value to be a tuple of the
name and extension.

The last part is setting a shorter name for the Markdown instance.

## Test Cases ##

Of first test is to assert that we see if the target directory exists.

{% highlight python %}
    def should_check_existance_of_target_dir(self):
        assert mod.os.path.calls('exists', self.target_dir)
{% endhighlight %}

We will use os.path.exists to check. The assert uses the .calls method to see
if os.path.exists was called with our target directory.

Next will want to assert that a markdown instance is created

{% highlight python %}
    def should_create_markdown_instance(self):
        assert mod.markdown.calls(
            'Markdown',
            extensions=['codehilite']
        ).once()
{% endhighlight %}

This time we check that the object is called with the extension 'codehilite' and that
it is only called once.

Now we need to get the files we plan on converting so we will use the os.listdir that uses
our mocked return value.

{% highlight python %}
    def should_find_markdown_files(self):
        assert mod.os.calls('listdir', self.src_dir)
{% endhighlight %}

Finally we can test that our file is actually converted by markdown

{% highlight python %}
    def should_join_source(self):
        assert mod.os.path.calls('join', self.src_dir, 'hello_world.markdown')

    def should_join_target(self):
        assert mod.os.path.calls('join', self.target_dir, 'hello_world.html')

    def should_convert_files(self):
        in_file = mod.os.path.join()
        out_file = mod.os.path.join()
        assert self.md.calls('convertFile', in_file, out_file)
{% endhighlight %}

We first assert that our function properly creates the paths to use for the
input and output files then calls markdown's convertFile function. The in_file
and out_file are actually the same dingus in this case, the join() will return
an object we can use to test with.

Now that the tests are written we can add the classes to run them.

{% highlight python %}
    class WhenProcessingMarkdown(BaseProcessing):

        def setup(self):
            BaseProcessing.setup(self)
            mod.os.path.exists.return_value = False
            process_markdown(self.src_dir, self.target_dir)

        def should_create_target_directory(self):
            assert mod.os.calls('mkdir', self.target_dir)
{% endhighlight %}

WhenProcessingMarkdown inherits from our BaseProcessing class including all of
the test cases.  In our setup this time we want to make sure we run
BaseProcessing.setup with our instance and set the return value of
os.path.exists. After that we run our function.

Since our output directory doesn't exist in this test it will want to make sure
that we try to create it.

Because we need to test the other case where the directory already exists we
create a new test class where that is true.

{% highlight python %}
    class WhenProcessingMarkdownAndDirectoryExists(BaseProcessing):

        def setup(self):
            BaseProcessing.setup(self)
            mod.os.path.exists.return_value = True
            process_markdown(self.src_dir, self.target_dir)

        def should_not_create_target_directory(self):
            assert not mod.os.calls('mkdir')
{% endhighlight %}

This is very similar except that the exists() return value is True so we will
want to assert that we do not call mkdir at all.

# Implementation #
Our tests are complete and we can move on to our implementation.

{% highlight python %}
    import os

    import markdown

    def process_markdown(src_dir, target_dir):
        "Converts files from :param src_dir: to html in the :param target_dir:"
        if not os.path.exists(target_dir):
            os.mkdir(target_dir)

        md = markdown.Markdown(extensions=['codehilite'])

        for file in os.listdir(src_dir):
            name, ext = os.path.splitext(file)

            in_file = os.path.join(src_dir, file)
            out_file = os.path.join(target_dir, name + '.html')
            md.convertFile(in_file, out_file)
{% endhighlight %}

The implementation shouldn't be surprising after planning it out. Our function
takes 2 arguments, possibly creates the target directory, then converts each
file from our source directory.

You can download the [full source](https://github.com/philipcristiano/blog_tdd_markdown)
