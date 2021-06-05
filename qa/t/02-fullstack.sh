set -e
qa=$(environ qa $(pwd))
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
