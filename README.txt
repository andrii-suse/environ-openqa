environ utility generates scripts, which allow friendly management of services without privileged access to the system.
This is useful in both manual testing and scripting advanced cross-product communication.

== Introduction

Requires `environ` command to be present, (which additionally will provide templates for Postgres and Apache).

The templates can be generated for two types of cases:
- local : templates will use installed scripts (/usr/share/openqa/script)
- source : templates will use openQA source code

== To generate local templates refer README.local.txt

== To generate source templates refer README.source.txt

== Using templates to manage services

After `environ` command completes, a folder `qa1` with helper scripts will be created in the current directory.
Use bash completion to see available commands.
E.g. run 'qa1/start' to start all openQA services or 'qa1/ui/start' to start WebUI only.

   qa1/start
   qa1/status
   qa1/stop
   qa1/status
   qa1/db/sql '\dt'
   qa1/db/status
   qa1/ui/start
   qa1/status
   qa1/stop

== Using templates for starting worker and tests

If worker prerequisites are met for corresponding templates, a worker can be started and example job executed:

   qa1/worker1/start
   qa1/example/start_job

Then later check progress in a web browser using address returned by command qa1/print_address or using client script:

   qa1/status
   qa1/worker1/status
   qa1/client jobs

Clone a job from another instance:

   qa1/clone_job --from openqa.opensuse.org 1752000

Then later check progress in a web browser using address returned by command 'qa1/print_address' or using the command '$qa job get'.
Script clone_distri_opensuse will set up needles from 'os-autoinst-distri-opensuse' in the corresponding environ, use it as an example how to set up custom needles.

== Using templates for isotovideo examples

If source templates are ready for os-autoinst project, it is possible to run the example job:

   ai1/example/isotovideo

The command above should generate result in 'ai1/exaple/testresults/result-shutdown.json' and print "result" : "ok" at the end


WARNING further runs of command 'environ qa' will normally fully wipe out existing data in folder qa1.
It is possible to use up to 10 slots and run openQA instances in parallel, e.g. command 'environ qa5 $sourcedir' will create folder qa5, which can be used concurrently with the rest qaN. (It will conflict only with 'qa5' created in another location).
