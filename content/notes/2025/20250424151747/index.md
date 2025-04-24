+++
date = "2025-04-24T15:17:47.742562819Z"

[taxonomies]
tags = ["docker", "stackoverflow", "homelab"]
+++

Something went wrong on a homelab server and Docker stopped cleaning up old overlays. 

Running `docker system prune -a -f`  ([via](https://stackoverflow.com/questions/31712266/how-to-clean-up-docker-overlay-directory)) seemed to fix it. 

`Total reclaimed space: 149GB` :tada:
