+++
date = "2025-02-24T13:28:16.697821436Z"

[taxonomies]
tags = ["delta", "postgres", "minio", "datafusion"]
+++

I've on and off again spent time trying to find some replacement for Postgres for software I write. Postgres is wonderful but is also a heavy requirement for lots of little homelab services. I tend to run a Postgres instance for each service which takes quite a bit of memory and maintenance overhead. 

In Rust-land there is [DataFusion](https://datafusion.apache.org/) that has a SQL interface for querying and inserting data. Inserting data can be a bit messy though and seems very much not to be the focus. 

DataFusion is integrated well with [Delta](https://delta.io/) though! Delta appears really interesting! It can use memory, filesystem, or remote storage. It supports write fairly well, including (fairly manually) the maintenance items that folks complain about with Postgres (compaction/vacuuming). 

It took a day but I have a working prototype of creating a table on Minio, inserting data, and querying the table. Examples on Delta's site seem out of date and overly verbose at the same time. 


