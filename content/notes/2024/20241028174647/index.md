+++
date = "2024-10-28T17:46:47.759421707Z"

[taxonomies]
tags = ["declare_schema", "postgres"]
+++

With [0.0.9](https://crates.io/crates/declare_schema/0.0.9) of [declare_schema](https://crates.io/crates/declare_schema) I'm starting to fail if migrations cannot be run. At the moment this tends to be room for improvement on implementation vs limitations in Postgres.

Current limitations:
* Cannot modify table constraints, as of [17, only foreign keys can be anyway](https://www.postgresql.org/docs/17/sql-altertable.html#SQL-ALTERTABLE-DESC-ALTER-CONSTRAINT)
* Cannot modify indexes. I'd like to improve this but it's also super messy. Index creation can take a while. I'm not sure how I'd like to handle this so the method at the moment is now to create a new index an later drop the old one. 

I'm starting to get fairly confident in my usage of it. Going forward I hope to work more on docs and examples. 
