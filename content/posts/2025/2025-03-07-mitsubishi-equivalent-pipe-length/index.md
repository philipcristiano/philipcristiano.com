+++
title = "HVAC Journey: Mitsubishi Equivalent Pipe Length"

[taxonomies]
tags = ["mitsubishi", "hvac"]
+++

While trying to debug problems with my HVAC system I came across "equivalent pipe length". Mitsubishi seems to omit this from installation manuals but includes it in their engineering manuals.

Equivalent Pipe Length accounts for the pressure drop of fittings, valves, or bends in a line to help simplify limits for a system. If a system has a max line length of 100' the measured distance of 100' would assume no additional parts in line to drop the pressure. If you add fittings, valves, or bends then the measured length would need to be below 100' to stay within the system limits specified as equivalent pipe length.

### An example

As a practical example. Here is my system (as best I could model in [Diamond System Builder](https://www.mitsubishicomfort.com/diamond-system-builder)):

{{ linked_full_photo(path="system.png")}}

I have a single outdoor unit with 4 indoor units: a central air handler and 3 mini splits. The lengths listed in this diagram are the measured lengths. The system will calculate the equivalent pipe length automatically and check it against the equipment specifications listed, pretty cool.

I cannot however correctly model my system in Diamond System Builder though as the measured length for the Front Bedroom is 84', with 6 bends.

For [my outdoor unit](https://www.mylinkdrive.com/USA/SMART_MULTI/MandP_Systems/Outdoor_Equipment-1/Outdoor_Units-1/Current-13/MXZ_SM_SMART_MULTI_Hyper_heating_Heat_Pump-1/MXZ_SM48NAMHZ2_U1?product). The installation manual states the `Farthest piping length after Branch box` of 82'. The 82' is the equivalent pipe length NOT the measured pipe length.

{{ full_photo(path="max-length.png")}}

I've confirmed with a Mitsubishi representative that the installation manual uses the equivalent pipe length, not the measured pipe length. This aligns with the System Builder where I can input 82' if I use 0 bends. The max length I can use with the 6 real-world bends in my system is 76'.

In the engineering manual there is a calculation for the equivalent pipe length on this system:

{{ full_photo(path="equivalent-pipe-length-calculation.png")}}

Which is why I can only input 76' feet with 6 bends (76' + 6 * 0.99' = 81.94').

### How would someone know

I'm not sure how someone would know the installation manual uses equivalent pipe length. Maybe this is covered in training for Mitsubishi equipment. My Mitsubishi Diamond Elite contractors seem not to know about it though. Or at least this didn't seem to stop them from installing this equipment in what appears to me to be out of spec from the manufacturer.



