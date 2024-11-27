+++
date = "2024-11-27T16:07:36.758801324Z"

[taxonomies]
tags = ["docker", "github", "github-actions"]
+++

I've added some sanity checks [my common Github Actions](https://github.com/philipcristiano/workflows/blob/fd0adb05846ea6c596259915fdecfdc38dc7f136/.github/workflows/docker-build.yml#L49-L66) when I build Docker containers to run the `-h` of a tool after building the image. I've a couple times been bitten by shared lib versions across build vs runtime base images. This at least verifies that the binary is in place and works!

```
- name: Build
  uses: docker/build-push-action@v6
  with:
    platforms: ${{ inputs.docker_platforms }}
    context: ${{ inputs.context }}

    cache-from: type=gha
    cache-to: type=gha,mode=max

    load: true
    tags: local-build:${{ github.sha }}

    push: false

- name: Check Container
  if: inputs.check_command != ''
  run: |
      docker run local-build:${{ github.sha }} "-h"
```
