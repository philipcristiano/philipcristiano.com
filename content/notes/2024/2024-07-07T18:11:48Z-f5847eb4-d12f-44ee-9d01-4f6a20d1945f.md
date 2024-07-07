+++
+++

Works for me to try cleaning out a Docker registry: [Docker Registry Cleaner](https://github.com/philipcristiano/docker-registry-cleaner/). Keeps the last N images of each repo as determined by a label on the image. 

On each deploy to my homelab I set a label on the image to be used so this cleans up images I'm no longer using. 

Super alpha-y state... will likely result in data loss!  
