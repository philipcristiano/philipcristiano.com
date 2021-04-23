title: OmniOS on Vultr
id: 2016/09/omnios-on-vultr
date: 2016-09-08
tags: omnios, vultr, hosting
link:
description:
type: text

This week I started trying to install [OmniOS](https://omnios.omniti.com/) in a
[Vultr](https://www.vultr.com/) instance. I'm not sure where I first saw Vultr
listed but was drawn to it because they offer custom ISO installs. OmniOS isn't
supported by most hosting vendors so I would need to install via a custom ISO.

Setting up an account was quick on Vultr, including $5 free credit for opening
an account. When creating a new instance you can select the custom ISO after
you've added it via URL to your account. They will transfer the ISO to the
right datacenter, attach it, then boot up the instance.

The ISO booted fine but installing OmniOS onto the instance didn't work. It
turns out that the OmniOS installer doesn't like the way Vultr exposes disks as
block devices to the instance. This was mentioned by [Dan
McDonald](https://twitter.com/kebesays) in the #omnios channel after he helped
me debug. Originally [I
tweeted](https://twitter.com/kebesays/status/773271007008292864) about trying
to install it and he followed up. He was very helpful and mentioned that the
installer is due to be replaced which will work around this issue, but it won't
be right away.

It seems just running OmniOS on baremetal is the way to go. I might wind up
getting a colo'd box at this point.
