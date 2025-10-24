# launchpads

Testbed for Novation Launchpads (specifically mini 2 and 3).

The script `scratch.lua` is a simple standalone test script, addressing a Launchpad Mini [MK2] on norns MIDI port #1.

The script `mini-mk2.lua` is aimed at a Launchpad Mini [MK2] which (AFAICT) is identical in MIDI spec to the original Launchpad - just faster. This script wheels in [shado](https://github.com/cassiel/shado) (which must be installed alongside this repo) and implements a MIDI renderer and a test script.

The script `mini-mk3.lua` (TBD) is aimed at a Launchpad Mini [MK3] - which is presumably equivalent to a full-size Launchpad something (maybe the "X"?).

Big TBD: colour support. This is an unresolved design issue, so for now the renderers are monochromatic (although with brightness support).
