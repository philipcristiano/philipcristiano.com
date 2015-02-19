<!--
.. title: Debian Packaging an Erlang Relx Release
.. slug: debian-packaging-an-erlang-release
.. date: 2015-02-18 23:11:50 UTC
.. tags: erlang, packaging
.. link:
.. description:
.. type: text
-->

Creating an Erlang release with Relx is straightforward and quick but you still
need to get it onto a machine. You could script something yourself, maybe even
using a configuration management tool. You could also create a Debian package
which would make your sysadmin happy and even make it easy to uninstall!

In this example I'll use [FPM](https://github.com/jordansissel/fpm) although
the Debian toolchain would work as well. This will assume that you can already
make a release with Relx and that you put your release files into `rel` within
your project. This may not follow all Debian best-practices but it will give
you a `.deb` file that will install and look kind of like any other package.
The package will include the Erlang Runtime System so you won't need to install
Erlang on the target system or any other dependencies before installing your
package.

# Application configuration

You likely already include a `sys.config` file with your release but it would
be nice to be able to configure the release after the package has been installed.
This is usually done with files in `/etc` or `/etc/PACKAGE`. Your `sys.config` can
be easily updated to make this happen!

Assuming you aren't configuring anything to start your `sys.config` would look like

    [].

With a `relx.config` including

    {sys_config, "./rel/sys.config"}.

To make this include an `/etc` file using the [config
documentation](http://www.erlang.org/doc/man/config.html) says you can include
a file path (absolute path preferred). This would make your Relx `sys.config`
look like:

    ["/etc/PACKAGE/PACKAGE.config"].

Simple! We don't need any post-install configuration right now but we should include
the config-less file so that Erlang can find it when trying to use `sys.config` Create
a file in `rel/PACKAGE/PACKAGE.config`:

    [].

Now this file can be updated with your configuration management tool without requiring
changing any files within the release!


On Debian/Ubuntu systems it's not uncommon to have a `/etc/default/PACKAGE` file as
well that allows you to add any environment variables you would like to use for
your application. I ran across this needing to set the `ulimit`. For now
we will create a file in `rel/etc/default/PACKAGE` that sets the `ulimit`.


    ulimit -n 65536

# Making a user

It's nice to have a system user that runs your release and not require some other
tool to create it. This can be done with FPM's `--before-install` option to pass
in the path to an appropriate script. More can be included but for now we will
create a file `rel/before-install` with the contents

    adduser PACKAGE --system

So that before this package is installed `dpkg` will create the user for us.

# Init

Your release should generally start right after the system does and it is
helpful to follow the standard init system of your distribution. This becoming
SystemD or Upstart depending on your distribution/derivative but for this
example we will stick with SysV-style init. This get slightly more complex but
we will start with the example and then walk through each line. This requires
that you use the extended start script from Relx with the option
`{extended_start_script, true}.`

    #!/bin/sh
    HOME=/opt/PACKAGE/

    [ -f /etc/default/PACKAGE ] && . /etc/default/PACKAGE

    mkdir -p /var/log/PACKAGE

    chown -R /opt/PACKAGE /var/lib/PACKAGE /opt/PACKAGE/log /var/log/PACKAGE

    su PACKAGE -mc "/opt/PACKAGE/bin/PACKAGE $@"

First `#!/bin/sh`, use the sh to execute.

Erlang and your release really want a `HOME` variable. We will for now install
the application into `/opt` so that `/opt/PACKAGE` will be used as `HOME`

Next we test for the defaults file we created before and if it exists we will
source it into this script. While the package will create the file it's still
polite to check if it exists before sourcing.

`mkdir` and `chown` are used so that the log/var directories and the release
itself all belong to the user we created in `before-install`. More directories
can be added if you need something specific.

Finally with `su` we will pass the arguments to the init script through
to the extended start script from Relx. The extended start script includes
things like `start` and `stop` that are familiar for an init script but
also includes ways to easily get a remote console connected to the Erlang
VM!

Since this script will use a dir in `/var/lib` create the respective directory
within rel `rel/var/lib/PACKAGE`

# Creating the Package

Until now we just created files that would be used by FPM, now we can
tell FPM to create the package. This could be done on any OS, not just
the one that you intend to distribute the package to, but it's generally
easier to use the same OS as we will include the Erlang Runtime System
with the package as well.

	fpm -s dir -t deb -n PACKAGE -v VERSION \
		--before-install=rel/before-install \
		_rel/PACKAGE=/opt/ \
		rel/init=/etc/init.d/PACKAGE \
		rel/var/lib/PACKAGE/=/var/lib/PACKAGE/ \
		rel/etc/PACKAGE/PACKAGE.config=/etc/PACKAGE/PACKAGE.config \
		rel/etc/default/PACKAGE=/etc/default/PACKAGE

Going through some of the options

`-s dir` says to create this package from a directory, instead of some other
packaging format (of which FPM supports many!)

`-t deb` creates a Debian package as output

`-n PACKAGE` name the package

`-v VERSION` Give the package this version. This should probably be determined
by your Makefile or build system and not be hardcoded.

`--before-install=rel/before-install` Adds the `before-install` script for FPM
so that it can be executed when you are installing the package.

The rest of the options tell FPM to take the relative file location and place it
at the absolute location when installing the package. This includes the release
into `/opt/`, our init script, var/lib directory, `etc` config, and defaults
file.

# You now have a package!

Running this command will create the package for you and output a `.deb` file
you can install on another machine. This includes ERTS and requires no dependencies
beyond what comes in a fresh install! If you've found this helpful please let
me know on [Twitter](http://twitter.com/philipcristiano)!
