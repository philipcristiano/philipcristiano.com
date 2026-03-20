+++
date = "2026-03-20T17:51:51.810820353Z"

[taxonomies]
tags = ["sqlx", "rust", "calibre-metadata-api"]
+++

[SQLx](https://github.com/launchbadge/sqlx) [0.9](https://github.com/launchbadge/sqlx/pull/3383) will have a `sqlx.toml` format that can specify DB connections. It was merged a while ago but isn't released yet. It was nice for updating [calibre-metadata-api](https://github.com/philipcristiano/calibre-metadata-api) to have multiple `sqlite` DBs ([PG example](https://github.com/launchbadge/sqlx/tree/main/examples/postgres/multi-database)), one for Calibre and one for Calibre-Web. Without this support the builds with 2 databases would fail for any `query_as!` macros connecting to the incorrect DB.
