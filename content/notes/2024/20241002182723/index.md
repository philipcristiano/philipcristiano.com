+++
date = "2024-10-02T18:27:23.016578200Z"

[taxonomies]
tags = ["jwk", "jwt", "prest", "kanidm"]
+++

I'm trying to figure out if I can create [Service Accounts in Kanidm](https://kanidm.github.io/kanidm/stable/accounts/service_accounts.html) and get a JWT that will work with [pREST](https://docs.prestd.com). [pREST](https://docs.prestd.com/get-started/configuring-prest) can be configured to use a `.well-known` URL to pull a JWK. This would allow me to give a long-lived service account API key to each service and keep token generation out of my services. 

It looks like [not yet](https://github.com/kanidm/kanidm/issues/2217#issuecomment-1909797927)! But they seem to be aware of this use case.  
