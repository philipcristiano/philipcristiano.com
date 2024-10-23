+++
date = "2024-10-23T15:10:46.010030941Z"

[taxonomies]
tags = ["traefik", "postgres"]
+++

While upgrading to [Postgres 17](https://www.postgresql.org/docs/release/17.0/) I ran into a few problems in my setup:

* I didn't update `pg_dump` as well, so backups stopped for a few days
* `pg_dump` for Postgres 17 (in some conditions? at least my setup) requires ALPN with TLS. 

From the release notes:

```
Allow TLS connections without requiring a network round-trip negotiation (Greg Stark, Heikki Linnakangas, Peter Eisentraut, Michael Paquier, Daniel Gustafsson) 

This is enabled with the client-side option sslnegotiation=direct, requires ALPN, and only works on PostgreSQL 17 and later servers.
```

I run [Traefik](https://doc.traefik.io/traefik/) to proxy Postgres connections, taking advantage of TLS SNI so a single Postgres port can be opened in Traefik and it will route the connection to the appropriate Postgres instance. Traefik ... understandly... doesn't default to advertising that it supports `postgresql` service over TLS. [This must be done explicitly](https://doc.traefik.io/traefik/https/tls/#alpn-protocols). 

In Traefik I was setting logs such as `tls: client requested unsupported application protocols ([postgresql])`

From `pg_dump` the log was `SSL error: tlsv1 alert no application protocol "postgres"`

Fixing this required configuring Traefik to explicitly say `postgresql` was supported. 

```toml
# Dynamic configuration

[tls.options]
  [tls.options.default]
    alpnProtocols = ["http/1.1", "h2", "postgresql"]
```

This as documented, is dynamic configuration. It must go in a dynamic config file declaration, not the static. In my static config I needed to add 

```toml
[providers]
  [providers.file]
    directory = "/local/dynamic"
    watch = true
```

Where `/local/dynamic` is a dir that contains dynamic configuration. I was unable to get the `alpnProtocols` set with Nomad dynamic configuration. I always ran into `invalid node options: string` when Traefik tried to load the config from Consul. Maybe from [this](https://github.com/traefik/traefik/issues/5507)
