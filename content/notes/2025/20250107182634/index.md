+++
date = "2025-01-07T18:26:34.759893824Z"

[taxonomies]
tags = ["wireguard", "duckduckgo"]
+++

I've had trouble with connections from my phone with WireGuard for a while. For maybe 2 years it wasn't a big enough issue to worry about. Finally looking, it seems to be an MTU issue that winds up causing problems for some sites, like [Duck Duck Go](https://duckduckgo.com/). When I had that set as my default search engine it feels like the Internet is broken. 

Setting the MTU to 1420 in my router WireGuard config seems to have fixed it! It was previously at 1200... for a reason I cannot recall. 
