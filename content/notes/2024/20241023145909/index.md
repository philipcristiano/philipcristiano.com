+++
date = "2024-10-23T14:59:09.223294674Z"

[taxonomies]
tags = ["rust", "sqlx", "postgres"]
+++

Pleased again with SQLx tests [while adding tests against Postgres](https://github.com/philipcristiano/declare-schema/pull/87) to test migrations. Previously there wasn't any automated tests for "what does this lib pull from Postgres", I was doing that manually. 

```rust
    #[sqlx::test]
    fn test_drop_foreign_key_constraint(pool: PgPool) {
        crate::migrate_from_string(
            r#"
                CREATE TABLE items (id uuid NOT NULL, PRIMARY KEY(id));
                CREATE TABLE test (id uuid, CONSTRAINT fk_id FOREIGN KEY(id) REFERENCES items(id))"#,
            &pool,
        )
        .await
        .expect("Setup");
        let m = crate::generate_migrations_from_string(
            r#"
               CREATE TABLE items (id uuid NOT NULL, PRIMARY KEY(id));
               CREATE TABLE test (id uuid)"#,
            &pool,
        )
        .await
        .expect("Migrate");

        let alter = vec![r#"ALTER TABLE test DROP CONSTRAINT fk_id CASCADE"#];

        assert_eq!(m, alter);
```
