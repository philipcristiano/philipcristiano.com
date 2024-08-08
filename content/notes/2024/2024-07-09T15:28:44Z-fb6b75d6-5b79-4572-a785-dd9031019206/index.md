+++
+++

Interesting to see [Rust Otel discussing the friction for (tokio)-`tracing`](https://github.com/open-telemetry/opentelemetry-rust/issues/1571). Tracing with [DataDog](https://www.datadoghq.com/) was really convenient. I always wanted to get our shop moved to Otel to eventually be able to move away from DataDog though, partially due to pricing, partially due to more adoption of Google Cloud and not wanting to ship data out just for tracing. 

I lean towards wanting [tokio-tracing](https://github.com/tokio-rs/tracing) to be a/the supported case. I haven't found a solution with Otel that I really like. The initial setup has always seemed tricky, and with a cross-cutting concern like tracing, adopting Otel seems heavyweight. A single ecosystem (Otel) across language stacks is super appealing. At this point I'm mostly writing Rust things though so that isn't a huge selling point for me. 

I do finally have a [tracing setup in a lib](https://github.com/philipcristiano/rust_service_conventions/) that is working well, but haven't gotten distributed tracing going yet. I'm fine adopting Otel for wire formats but I'd like to keep `tracing` in my app. I've yet to find a good way to thread [W3C tracecontext](https://www.w3.org/TR/trace-context/) into Otel output. 
 
