qa=$1

set -euo pipefail

[ -d "$qa" ] || (
    echo 'First argument must be a valid directory'
    exit 1
) >&2

[ -d "$qa" ] || (
    echo 'First argument must be a valid environ directory, e.g. created with command "environ qa <path to source>"'
    exit 1
) >&2

$qa/start
$qa/worker1/start

$qa/example/start_job

max_wait=20

sleep 10

$qa/worker1/status

set +x
while [ $((max_wait--)) -gt 0 ] && $qa/client jobs get | grep result | tail -n 1 | grep -q none ; do
    sleep 10
    echo -n .
done

[ $max_wait -gt 0 ] || ( $qa/client jobs get; echo "Timeout exceeded"; exit 1 )
$qa/client jobs get
$qa/client jobs get | grep result
$qa/client jobs get | grep result | tail -n 1
set -x
$qa/client jobs get | grep result | tail -n 1 | grep -q passed
