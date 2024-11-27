+++
date = "2024-11-27T15:59:31.059429069Z"

[taxonomies]
tags = ["docker"]
+++

I'm running into [this issue](https://github.com/distribution/distribution/issues/4461) with my local Docker Registry where things seem corrupted after a garbage collect. I though it was how I was deleting multi-arch images, but maybe not! I'm just disabling garbage collection for now in my system. 
