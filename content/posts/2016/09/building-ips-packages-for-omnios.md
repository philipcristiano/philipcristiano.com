---
title: Building IPS Packages For OmniOS
id: 2016/09/building-ips-packages-for-omnios
date: 2016-09-14
tags: omnios, ips, packaging
link:
description:
type: text
---

I've started trying to package some software for OmniOS for personal use. The
[OmniOS Packaging](https://omnios.omniti.com/wiki.php/PackagingForOmniOS) page
in the wiki goes through how to do it using the tools used to build the OS.
This is a bit more than I would want to do when publishing software to GitHub.
I would rather not rely on a repository used to build the OS just to package
one piece of software.

A few months ago I was trying to package a personal project and got most of the
way there! So far there is a [make
target](https://github.com/philipcristiano/brewery-manager/blob/9cb4ee5d2e3f19c84130db4580c62bf67b8239a7/Makefile#L47)
that will package an Erlang release into an IPS package. I think it only got as
far as putting the files on disk. I still to add the SMF manifest and fix
permissions, but it's much smaller when used to package a single piece of
software.
