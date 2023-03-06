title: How To Package a Service For OmniOS
id: how-to-package-a-service-for-omnios
date: 2016-09-21 19:44:19 UTC
tags: draft, packaging, omnios, smf
link:
description:
type: text

A [previous post](2016/09/how-to-package-for-omnios.html) showed how to install
files. If you wanted to run a service from that package there are a few more
steps.

# Service Management Facility

The [Service Management Facility](https://en.wikipedia.org/wiki/Service_Management_Facility) provides a way to manage services in OmniOS. If you are running a service you installed from a package, this is the way to do it.

# Steps to Package and Run a Service

We will need to complete a few steps to package up a service and deploy it with IPS.

* Create an SMF manifest that instructs SMF how to run our service

* Deploy the SMF manifest

* Start the service.

Optionally, the service can be modified to read SMF properties so that it can
be configured through `svccfg`

# Tools

*

# Creating an Echo Server



# Creating an SMF Manifest

A service manifest is an XML documents that contain the information required to
run a command as a service. This would normally mean that you have to create a
new XML document for each service. Thankfully there is the tool
[Manifold](https://code.google.com/archive/p/manifold/) that can create an
manifest with answers to the relevant questions.


