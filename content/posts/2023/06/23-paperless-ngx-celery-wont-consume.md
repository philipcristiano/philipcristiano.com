+++
title      = "Paperless-ngx Celery won't consume documents"
date       = 2023-06-23

+++

When running [Paperless-ngx](https://docs.paperless-ngx.com/) I ran into a problem where the Celery process in Docker (as part of supervisord) would start, supervisor would report it running, but the Celery process appeared to do nothing.

The last related lines I would see were:

```
INFO success: celery entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
[INFO] [paperless.management.consumer] Adding [REDACTED] to the task queue.
```

I'm not sure what part of Celery does this, maybe it's just Paperless? But eventually I found a `.__celery.lock` file in the Paperless data directory. Removing that allowed everything to work again.

This was likely caused with Nomad terminating the process and the lock file not getting cleaned up. I now have my Nomad job remove `.*.lock` files before starting Paperless.
