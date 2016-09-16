<!--
.. title: How to Package Your Software for OmniOS
.. slug: how-to-package-for-omnios
.. date: 2016-09-16 18:56:13 UTC
.. tags: omnios, packaging
.. link:
.. description:
.. type: text
-->

[Packaging for OmniOS](https://omnios.omniti.com/wiki.php/PackagingForOmniOS)
goes over how to create a package using the [same build
system](https://github.com/omniti-labs/omnios-build) as is used for building
OmniOS. The layout of this repository seems designed for building already
written software to be used in OmniOS. If you need to package your own software
then this can be more overhead then you are looking for. The tools used by that
GitHub repository are included in the default installation of OmniOS and have
plenty of documentation on Oracle's site about how to use IPS. It turns out you
can start making packages for OmniOS with only a few commands.

This post will cover the tools required to create a package, not necessarily
best practices in packaging for OmniOS.

I've created an [example
repository](https://github.com/philipcristiano/ips-hello-world) that can build
and upload a package to an IPS package depot if you want to skip ahead.


# Tools

The packaging commands we will be using are

* [pkgsend](https://docs.oracle.com/cd/E53394_01/html/E54763/pkgsend-1.html) - Generates the package manifest and publishes the package

* [pkgmogrify](https://docs.oracle.com/cd/E23824_01/html/E21796/pkgmogrify-1.html) - Transforms the package manifest

* [pkglint](https://docs.oracle.com/cd/E23824_01/html/E21796/pkglint-1.html) - Linter for package manifests

* [pkgfmt](https://docs.oracle.com/cd/E23824_01/html/E21796/pkgfmt-1.html) - Formatter for package manifest

* [pkgrepo](http://docs.oracle.com/cd/E36784_01/html/E36870/pkgrepo-1.html) - (optional) Refresh the repository search index after upload


## Example Application

We will be packaging a Hello World script stored in `hello-world.sh`.

```
#!/usr/bin/bash

echo Hello World!
```

This file needs an execute bit as well so we will run

```
chmod +x hello-world.sh
```

## Building the Manifest

`pkgsend` will generate a manifest for us if we can build a directory that
mimics the deployed layout. If we put our script in `build/usr/bin` (and remove
the extension) then run `pkgsend generate build` we will get a manifest of
files and directories to package.

```
$ /usr/bin/pkgsend generate build
dir group=bin mode=0755 owner=root path=usr
dir group=bin mode=0755 owner=root path=usr/bin
file usr/bin/hello-world group=bin mode=0755 owner=root path=usr/bin/hello-world
```

Our manifest so far says we need two directories and a file. This would be
enough of a manifest to start with but can be problematic if the directories
don't line up with the host used to install the package. It would be better to
remove the directories and assume that `/usr/bin` already exists on the system,
since it really should already be there.

The command `pkgmogrify` can take a manifest and a transform file and output a
transformed manifest.

A simple transform to do this will be stored in `transform.mog`

```
<transform dir path=usr -> drop>
```

This will drop any directories that include the path `usr`. If you need are
building a more complex directory structure then using something like
`usr/bin$` as the path will only drop the common `/usr/bin` elements from the
manifest.


For this we will write the manifest to a file the mogrify it to remove the
directories.

```
$ /usr/bin/pkgsend generate build > manifest.pm5.1
$ /usr/bin/pkgmogrify manifest.pm5.1 transform.mog

file usr/bin/hello-world group=bin mode=0755 owner=root path=usr/bin/hello-world

```

This now has just our script in the manifest. Using `pkgmogrify` we can easily
script changes to manifests instead of relying on manual changes to clean up a
generated manifest.

We'll write the updated manifest to a new file

```
$ /usr/bin/pkgmogrify manifest.pm5.1 transform.mog > manifest.pm5.2
```

## Package Metadata

We have the manifest for what the package should contain but we still need to
describe the package with metadata. We will need to include at least a name,
version, description, and summary for the package.

The name and version are contained in an [Fault Managed Resource
Identifier](http://docs.oracle.com/cd/E23824_01/html/821-1474/fmri-5.html) or
FMRI.

I recommend reading the link above about proper format and conventions for
FMRIs but for now we will write `metadata.mog` to contain

```
set name=pkg.fmri value=example/hello-world@0.1.0,0.1.0-0.1.0:20160915T211427Z
set name=pkg.description value="Hello World"
set name=pkg.summary value="Hello World shell script"
```

We can use `pkgmogrify` to combine our metadata and current manifest file to
make a file manifest used for publishing our package. In this case we use
`pkgfmt` to format the file as well.

```
$ /usr/bin/pkgmogrify metadata.mog manifest.pm5.2 | pkgfmt > manifest.pm5.final
```

## Linting

The manifest we have now should work for publishing the package. We can verify
using `pkglint` on the final manifest to check.

```
$ /usr/bin/pkglint manifest.pm5.final
Lint engine setup...
Starting lint run...
$ echo $?
0
```
No errors or warnings, wonderful!

## Publishing the Package

We now have a directory structure for the package we would like to create as well as a manifest saying how to install the files. We can publish these components to an IPS package depot with `pkgsend`


```
$ pkgsend publish -s PKGSERVER -d build/ manifest.pm5.final
pkg://myrepo.example.com/example/hello-world@0.1.0,0.1.0-0.1.0:20160916T182806Z
PUBLISHED
```

`-s` specifies the package server, `-d` specifies the directory to read, and we pass along the path to our manifest. Our package was then published!

### Troubleshooting

If you are using an HTTP depotd server to publish and see the error `pkgsend:
Publisher 'default' has no repositories that support the 'open/0'` you will
need to [disable read-only mode](/2016/09/error-publishing-to-pkgdepotd.html)
for the server or publish to a filesystem repository.


## Refresh the Package Search Index

The HTTP depotd interface doesn't refresh the search index when a package is published. This can be done with the `pkgrepo` command.

```
$ pkgrepo refresh -s PKGSERVER
```
