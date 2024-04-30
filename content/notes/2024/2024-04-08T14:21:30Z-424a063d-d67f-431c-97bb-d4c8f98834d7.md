+++
date = "2024-04-08T14:21:30Z"
+++

There is an open [PR](https://github.com/distribution/distribution/pull/4285) to improve Docker registry garbage collection. It helps clean up multi-arch images, which I tend to pull a bunch. 

Giving [it](https://github.com/philipcristiano/distribution/pull/1) a try with a [personal build](https://hub.docker.com/layers/philipcristiano/distribution/3.0.0-alpha1-pr-4285/images/sha256-3b5e4a663346437881a1ce1a7c3ded847099365ea5e60512637bb884e8c1676a?context=repo) it wound up reducing my registry size by about 50%!
