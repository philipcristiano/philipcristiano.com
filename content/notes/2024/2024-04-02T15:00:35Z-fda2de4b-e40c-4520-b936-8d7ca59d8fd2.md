+++
date = "2024-04-02T15:00:35Z"
+++

In today's "Solving Problems I Create For Myself" news:

I updated my [`docker-prefetch-image](https://github.com/philipcristiano/docker-prefetch-image) daemon to attempt pulling from alternative Docker repositories in the event an image pull fails. 

This fixes the case where updating my Docker Repository infrastructure prevents pulling/running new Docker images. Now the prefetching will attempt to pull from my local repository and fall back to [Docker Hub](https://hub.docker.com), then tag the image as if it came from my repository.
