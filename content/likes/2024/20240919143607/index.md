+++
date = "2024-09-19T14:36:07.009377147Z"

[taxonomies]
tags = ["rust", "sqlx", "this-week-in-rust"]

[extra]
in_like_of = "http://www.matildasmeds.com/posts/no-more-unchecked-sqlx-queries/"
+++

I love [sqlx](https://docs.rs/sqlx/latest/sqlx/) and type checked queries but always found it annoying to duplicate a bunch of queries vs using the dynamic query builder (which isn't type checked). [Using `Option` and `NULL`s](http://www.matildasmeds.com/posts/no-more-unchecked-sqlx-queries/) seems to improve things though! 


```rust
// Postgres version
let ids = sqlx::query_as!(
    Uuid,
    "SELECT id FROM users \
     WHERE ($1::timestamptz IS NULL OR updated_at < $1) \
       AND ($2::timestamptz IS NULL OR updated_at > $2) \
       AND ($3::boolean IS NULL OR is_guest = $3)",
    updated_before_option,
    updated_after_option,
    is_guest_option,
    )
    .fetch_all(&pool)
    .await;
```

[via](https://this-week-in-rust.org/blog/2024/09/11/this-week-in-rust-564/)
