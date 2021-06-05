set -euo pipefail

qa=$(environ qa $PWD)
$qa/ui/start
$qa/ui/status
$qa/db/status # db starts automatically with first service
$qa/ui/stop

rc=0
$qa/ui/status 2>/dev/null || rc=$?; test $rc -gt 0; rc=0

#############################################

$qa/livehandler/start
$qa/livehandler/status
$qa/livehandler/stop

$qa/livehandler/status >& /dev/null || rc=$?; test $rc -gt 0; rc=0


$qa/livehandler/start
$qa/livehandler/status
$qa/livehandler/stop

$qa/livehandler/status >& /dev/null || rc=$?; test $rc -gt 0; rc=0

$qa/livehandler/start
$qa/livehandler/status
$qa/livehandler/stop

$qa/livehandler/status >& /dev/null || rc=$?; test $rc -gt 0; rc=0

#############################################

$qa/websockets/start
$qa/websockets/status
$qa/websockets/stop
$qa/websockets/status >& /dev/null || rc=$?; test $rc -gt 0; rc=0

#############################################

$qa/gru/start
$qa/gru/status
$qa/gru/stop
$qa/gru/status >& /dev/null || rc=$?; test $rc -gt 0; rc=0

#############################################
# Alltogether

$qa/stop
$qa/db/stop

(
$qa/ui/status          || rc=$?; test $rc -gt 0; rc=0
$qa/gru/status         || rc=$?; test $rc -gt 0; rc=0
$qa/livehandler/status || rc=$?; test $rc -gt 0; rc=0
$qa/websockets/status  || rc=$?; test $rc -gt 0; rc=0
$qa/db/status          || rc=$?; test $rc -gt 0; rc=0
) >& /dev/null

$qa/db/start
$qa/ui/start
$qa/ui/status

$qa/gru/start
$qa/gru/status

$qa/livehandler/start
$qa/livehandler/status

$qa/websockets/start
$qa/websockets/status

# in fact services may stop shortly after startup, so let's wait briefly and check status once again
sleep 2

$qa/ui/status
$qa/gru/status
$qa/livehandler/status
$qa/websockets/status

$qa/livehandler/stop
$qa/websockets/stop
$qa/gru/stop
$qa/ui/stop
$qa/db/stop

(
$qa/ui/status          || rc=$?; test $rc -gt 0; rc=0
$qa/gru/status         || rc=$?; test $rc -gt 0; rc=0
$qa/livehandler/status || rc=$?; test $rc -gt 0; rc=0
$qa/websockets/status  || rc=$?; test $rc -gt 0; rc=0
$qa/db/status          || rc=$?; test $rc -gt 0; rc=0
) >& /dev/null

echo PASS $0
