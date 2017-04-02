<!--
.. title: Execute AWS User Data on OmniOS
.. slug: execute-aws-user-data-on-omnios
.. date: 2017-04-02 14:49:11 UTC
.. tags: omnios, aws, packer, smf
.. link:
.. description:
.. type: text
-->

As I started to use the [OmniOS](http://omnios.omniti.com/) on AWS I ran into
the problem that it does not, by default, include a way to execute the AWS User
Data script when starting an instance. The User Data scripts provides a
wonderful mechanism to bootstrap new instances. Without it, you may be required
to use a configuration management tool or manually configure instances after
they have booted.

The script is helpfully available through the [instance metadata
API](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html)
at 169.254.169.254 with the URL `http://169.254.169.254/2016-09-02/user-data`. It
should be simple to pull that down and execute the script with SMF!

I've put together [a script to do this](https://github.com/philipcristiano/AWSMF-Data).
It runs with SMF with a default timeout 15 minutes and will restart if there are errors.
There is a handy dandy `install` script in the repo that will download and install the
needed files. At the moment this isn't packaged as this script is needed before I would
set up a package repository.

There is still the problem of how to get this into an AWS AMI.
[Packer](https://www.packer.io/) can build the image for us so that the AMI we
launch will already have this script.  The
[buildfile](https://github.com/philipcristiano/packer-omnios/blob/master/build.json)
for this image is rather simple but the whole process is a powerful one.

To get your own OmniOS AMI with AWSMF-Data installed you can use the above Packer build.


* Install Packer

* Clone the repo

```
$ git clone https://github.com/philipcristiano/packer-omnios.git`
```

* Execute `build.sh` after setting a few variables

```
$ export AWS_ACCESS_KEY_ID=...
$ export AWS_SECRET_ACCESS_KEY=...
$ export VPC_ID=...
$ export SUBNET_ID=...

$ ./build.sh
```

`VPC_ID` and `SUBNET_ID` are only required if you have a need to specify them
(like no default VPC in your account), in which case the `build.sh` can be
modified.

From here we can create User Data scripts in AWS and have new EC2 instances run
code when they start!
