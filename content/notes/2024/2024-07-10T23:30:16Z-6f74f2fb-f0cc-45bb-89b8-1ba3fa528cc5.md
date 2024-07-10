+++
+++

I was [able to get tracecontext passthrough to OTel](https://github.com/philipcristiano/rust_service_conventions/pull/97/commits/a8e226f7eb81058ce8c688681c2987410ec787fa) working! I was missing the `opentelemetry_sdk::trace::TracerProvider` which pulls in the infomation to help build the OTel data that gets sent to collectors.  
