title: Upgrading OmniOS is Surprisingly Easy
id: 2016/09/upgrading-omnios-is-surprisingly-easy
date: 2016-09-13
tags: omnios
link:
description:
type: text

As part of the process of shaving some yaks today I wound up needing to upgrade
my development server to the latest version of
[OmniOS](https://omnios.omniti.com/). I originally installed the LTS version
and planned to stay there till the next release. It turns out there isn't much
reason not to upgrade to the latest version. You will get needed security
updates either way but be able to get around any bugs with OS-related things
that have been fixed in the mean time.

The [Upgrading to r151014 or
later](https://omnios.omniti.com/wiki.php/Upgrade_to_r151014) page had the
needed information and worked quickly. I ran into an issue with the datasets
for my zones causing the problem `pkg: Unable to clone the current boot
environment` when trying to update with `pkg`. All the zones I care about
are recreated with configuration management so I didn't have a problem
destroying the dataset and recreating them. If it were production I would
have at least snapshotted the needed datasets before destroying them.

For the next release I think I'll update a bit sooner!
