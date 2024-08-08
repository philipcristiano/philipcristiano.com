+++
+++

Worked on a [PR for sqlparser](https://github.com/sqlparser-rs/sqlparser-rs/pull/1291) to struct-ify some things. Part of making a SQL `create table` declarative way to generate SQL migrations at runtime. I had a version in Erlang before and enjoyed it enough that I want it in Rust. 

[sqlmo](https://github.com/kurtbuilds/sqlmo) does part of the migration generation piece and I'm working to [add some pieces there](https://github.com/kurtbuilds/sqlmo/pull/2) as well. 

I missed a release of `sqlparser` though so the embed-able version of my lib will need to wait for merge/release before I can push my version to [crates.io](crates.io). The bin version of it will be something like the [atlas](https://atlasgo.io/) OSS tool, but without any cloud component.  
