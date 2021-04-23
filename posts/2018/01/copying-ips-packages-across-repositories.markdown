title: Copying IPS Packages Across Repositories
id: 2018/01/29/copying-ips-packages-across-repositories
date: 2018-01-29
tags: omniosce, omnios

With the release of [OmniosCS](https://omniosce.org/) I've found myself needing
packages from [OmniTI's Managed
Services](https://pkg.omniti.com/omniti-ms/en/index.shtml) repository.

My first attempt was to copy packages with
[pkgrecv](https://docs.oracle.com/cd/E53394_01/html/E54747/howtoupdaterepo.html).
This however caused problems where the IPS server doesn't know about the
repository. Adding the repository to the IPS server didn't fix the problem.

This can be fixed by [changing the
repository](https://docs.oracle.com/cd/E36784_01/html/E36856/chngpublisher.html)
FMRI before uploading.
