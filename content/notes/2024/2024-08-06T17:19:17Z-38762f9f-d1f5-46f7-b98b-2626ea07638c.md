+++
+++

I guess I'll look forward to PostgreSQL 17, between [better upserts](https://simonwillison.net/2024/Aug/5/how-to-get-or-create-in-postgresql/#atom-everything) and some [label improvements](https://www.yetto.app/blog/post/how-labels-work/). 

The `MERGE` seems to take more code than I'd like, I wish `ON CONFLICT` didn't bloat and could have an option for `ALWAYS RETURNING` that would return the row even if not modified. I'd deal with the bloat if it were simple code and always returned the row.  
