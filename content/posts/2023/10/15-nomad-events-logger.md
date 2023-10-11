+++
title      = "Prefetching Docker Images"
date       = 2023-10-11

+++

While running Nomad I've been running into a bootstrapping/critical path problem. I have a Docker Registry running in the cluster and pulling an image requires:

* [Docker Registry](https://docs.docker.com/registry/)
* [Traefik](https://traefik.io/)
* [GoCast](https://github.com/mayuresh82/gocast)
* [Minio](https://min.io/)

The Registry is required to serve the image.

Traefik routes the requests to the Registry as well as requesting Lets Encrypt certificates

GoCast announces the floating IP for Traefik

Minio stores the images for the Registry

## Problems updating images

Separate from bootstrapping, just updating the image of many of these will require everything to already be running, just to pull the next image. There is an [open bug](https://github.com/hashicorp/nomad/issues/6380) to address this in Nomad, but it doesn't seem like it's going to be resolved anytime soon.

When updating Traefik I run into a condition that GoCast has created the floating IP addr on the host but Traefik isn't running. The floating IP won't work while Traefik is running-but-not-serving. GoCast BGP is working correctly in that the floating IP is not accounced to the network, but the updating host still can't reach the other-host instances of the floating IP. I'm not sure if [leaving the addr in place is a feature or a bug](https://github.com/mayuresh82/gocast/issues/25).

A way around this would be to run multiple instances of Traefik on each host. As currently setup though I need to bind multiple instances of Traefik to the same ports and [SO_REUSEPORT isn't supported](https://github.com/traefik/traefik/issues/9823). With GoCast I could map the floating IP ports to container ports and not require host networking (thus avoiding the port collision) but that may be quite burdensome to manage. I also haven't tried running multiple ports with GoCast NAT'ing.

## Solving part of the problem

For the Traefik case of not being able to pull the image there are some workarounds. Manually pulling, or [system batch jobs](https://github.com/hashicorp/nomad/issues/6380#issuecomment-1121425133) could solve this but is fairly manual.

[regclient](https://github.com/regclient/regclient) has a daemon mode that can pull/sync images to registries, but it [doesn't support pushing to a Docker Engine](https://github.com/regclient/regclient/issues/568).

## Docker Prefetch Image

I've started on a [tool to prefetch Docker images](https://github.com/philipcristiano/docker-prefetch-image/) based on a config file. Updating the config file appropriately to match the image used in Nomad Jobs is still a problem. This uses the [Docker Engine API](https://docs.docker.com/engine/api/v1.43/#tag/Image/operation/ImageCreate) via the Rust [docker_api](https://docs.rs/docker-api/latest/docker_api/index.html) crate to pull the image to the host.

Nomad Consul Template though can populate the config file from Consul to avoid manual file updates thought which isn't terrible. I'm not sure if there is a nice way to integrate with the Nomad API to watch what images might be needed and pull the in in advance of any job using it.

This has solved my case for updating parts of the critical path of Docker Image hosting. It doesn't fully solve the bootstrapping case though where none of the services are running yet. An idea though is to extend the config/API calls to have the "expected" image tag Nomad would look for and a "source". If the "expected" image cannot be pulled, try the "source" and tag it locally as the "expected" tag. This would allow prefetching all images required for bootstrapping the system!
