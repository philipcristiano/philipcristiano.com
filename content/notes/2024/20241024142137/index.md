+++
date = "2024-10-24T14:21:37.660215804Z"

[taxonomies]
tags = ["openssl", "rust", "reqwest"]
+++

Some of my projects recently failed during lockfile updates with:

```
error "OPENSSL_API_COMPAT expresses an impossible API compatibility level"
```

The lockfile updates included `openssl-sys-0.9.104`. I remember not really needing OpenSSL at all, leaning to use `rust-tls` for the most part. This was the push I needed to figure out why OpenSSL was still being included. 

`reqwest` includes `default-tls` as a default feature, which seems to be `native-tls` a.k.a OpenSSL. Removing default features worked for my projects

```
reqwest = { version = "0.12.4", features = ["rustls-tls", "json"], default-features = false }
```
