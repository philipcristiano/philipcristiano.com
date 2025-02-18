+++
date = "2025-02-18T14:07:12.237934535Z"

[taxonomies]
tags = ["minio", "homelab"]
+++

I ran into a problem with my homelab Minio cluster where a single node was able to corrupt the `ls` of a bucket. With that node turned off `ls` showed the latest files, with the node running `ls` wouldn't list any files added in the last month. Writes were fine in either case, other than not being `ls`-able. A manual heal on the cluster seemed to fix it fine enough.
