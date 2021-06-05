This file must be read as part of README.txt for generating openQA environ templates which use openQA source distribution.

== Prerequisites

All OpenQA dependencies for source distribution must be installed.
openQA and os-autoinst source code folders must be siblings, e.g
in this manual paths ~/project/openQA and ~/project/os-autoinst will be used.

== Generate scripts with installed environ templates

1. Install environ templates
    git clone https://github.com/andrii-suse/environ
    git clone https://github.com/andrii-suse/environ-openqa
    sudo make -C environ install
    sudo make -C environ-openqa install
2. Create folder `qa1` and generate openqa helper scripts into it:
    environ qa1 ~/project/openQA
3. (Optional*) generate os-autoinst scripts and build the project:
    environ ai1 ~/project/os-autoinst

Step 3 is optional, but openQA worker commands expect os-autoinst project to be built

== Generate scripts without installing environ templates:

1. Clone environ templates
    git clone https://github.com/andrii-suse/environ
    git clone https://github.com/andrii-suse/environ-openqa
2. Create folder `qa1` and generate openqa helper scripts into it:
    environ/bin/environ -l environ-openqa qa1 ~/project/openQA
3. (Optional*) generate os-autoinst scripts and build the project:
    environ/bin/environ -l environ-openqa ai1 ~/project/os-autoinst

Step 3 is optional, but openQA worker commands expect os-autoinst project to be built

WARNING further runs of command 'environ qa1' will normally fully wipe out existing content in folder qa1.
