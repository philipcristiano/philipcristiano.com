+++
title      = "Towards a more useful Matrix Synapse healthcheck"
+++

I've been running [Synapse](https://matrix-org.github.io/synapse/latest/welcome_and_overview.html) for about a year at this point and it's been fairly consistently the software that gives me the most trouble for my homelab.

A part I've started to address recently is the ineffectiveness of the [healthcheck endpoints](https://matrix-org.github.io/synapse/latest/reverse_proxy.html#health-check-endpoint). It always works! Which is a problem when the service isn't working and the healthcheck says it is. This is commonly when my Postgres server moves for some reason, Synapse never reconnects. It's a [known](https://github.com/matrix-org/synapse/issues/11473) [issue](https://github.com/element-hq/synapse/issues/11473).

I've worked around this with a healthcheck script that will probe the Synapse API

```bash
curl -fv http://127.0.0.1:{{ PORT }}/_matrix/client/v3/publicRooms -H "Authorization: Bearer {{ TOKEN }}"
```

The `TOKEN` needs to be a [user token](https://webapps.stackexchange.com/questions/131056/how-to-get-an-access-token-for-element-riot-matrix) which also gives this a bootstrapping problem where this check can only be in place after the server works. And a user changing their password will invalidate this token and take the server offline...

After a few days though it's solved my problem of Synapse breaking but pretending to be fine.
