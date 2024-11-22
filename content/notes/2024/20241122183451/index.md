+++
date = "2024-11-22T18:34:51.941452018Z"

[taxonomies]
tags = ["oriole_db", "postgres"]
+++

I'd love to try out [Oriole DB for the decoupled storage](https://www.orioledb.com/docs/usage/decoupled-storage) for running Postgres. Keeping all data on S3/Minio would ease my DB management for disks and remove any reliance on a remote filesystems for Postgres. 

The current limitation of `While OrioleDB tables and materialized views are stored incrementally in the S3 bucket, the history is kept forever. There is currently no mechanism to safely remove the old data.` prevents me from running it fully though. I'll have to keep an eye on the dev / next release. 
