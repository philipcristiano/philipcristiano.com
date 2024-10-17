+++
date = "2024-10-17T16:52:21.576725175Z"

[taxonomies]
tags = ["postgres", "rust", "sqlx"]
+++

Really impressed with [SQLx testing](https://docs.rs/sqlx/latest/sqlx/attr.test.html). Super simple to create tests that use the DB in a way that works well in dev and CI environments. I'm not using the migration feature but instead have my own setup to get the DB into the right state at the beginning of tests. 
