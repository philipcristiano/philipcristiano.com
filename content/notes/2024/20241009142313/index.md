+++
date = "2024-10-09T14:23:13.162296959Z"

[taxonomies]
tags = ["rust", "expense-tracker", "postgres"]
+++

Making a [pr to SQLx to add Postgres lquery arrays](https://github.com/launchbadge/sqlx/pull/3553). This took less time than I expected to try and fix. More time was spent wrangling my various projects to use a local `sqlx` dependency.

Postgres `ltree` has a [wonderful `?` operator](https://www.postgresql.org/docs/current/ltree.html#LTREE-OPS-FUNCS) that will check an array of `lquery`s. I plan to use this to allow filtering multiple labels in my [expense tracker](https://github.com/philipcristiano/et).

```
ltree ? lquery[] → boolean
lquery[] ? ltree → boolean
    Does ltree match any lquery in array?
```
