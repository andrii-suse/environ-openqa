This file must be read as part of README.txt for generating openQA environ templates which use openQA binary distribution.

== Prerequisites

OpenQA package must be installed.
OpenQA-worker package must be installed and apparmor profile for the worker must be tweaked, e.g. set in complain mode:

    sudo aa-complain /usr/share/openqa/script/worker

== Generate scripts with installed environ templates

1. Install environ templates
    git clone https://github.com/andrii-suse/environ
    git clone https://github.com/andrii-suse/environ-openqa
    sudo make -C environ install
    sudo make -C environ-openqa install
2. Create folder `qa1` and generate openqa helper scripts into it:
    environ qa1

== Generate scripts without installing environ templates:

1. Clone environ templates
    git clone https://github.com/andrii-suse/environ
    git clone https://github.com/andrii-suse/environ-openqa
2. Create folder `qa1` and generate openqa helper scripts into it:
    environ/bin/environ -l environ-openqa qa1

WARNING further runs of command 'environ qa1' will normally fully wipe out existing content in folder qa1.
