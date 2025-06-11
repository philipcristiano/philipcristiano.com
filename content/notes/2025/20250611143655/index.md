+++
date = "2025-06-11T14:36:55.469491400Z"

[taxonomies]
tags = ["restic", "minio"]
+++

I'm giving [Restic](https://restic.readthedocs.io) a go for backups with a NixOS system. The integration on NixOS is pretty easy to set up and backing up to Minio was painless. I still need to work on the sequencing from services that won't work with just a disk copy (sqlite mostly I think). 

I've mostly seen people ask about [Borg](https://www.borgbackup.org/) in the self-hosting community, but I wanted something S3-compatible natively and Borg doesn't seem to fit that. 
