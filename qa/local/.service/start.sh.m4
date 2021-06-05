set -e

ifelse(__service,worker1,`',__service,worker2,`',__service,worker3,`',
# this folder is create with command 'create_db openqa_test' below
[ -e __workdir/db/sql_openqa_test ] || {
    __workdir/db/start
    __workdir/db/create_db openqa_test
}
export OPENQA_DATABASE=test
export TEST_PG="DBI:Pg:dbname=openqa_test;host=__workdir/db/dt"
)
export OPENQA_BASEDIR=__workdir
export OPENQA_CONFIG=__workdir/openqa
export OPENQA_LOGFILE=__workdir/__service/.log

mkdir -p __workdir/openqa/db

define(`CMD',ifelse(__service,ui,openqa daemon,__service,gru,openqa gru -m test run,
__service,worker1,worker  --host http://127.0.0.1:__port --instance 1 --apikey 1234567890ABCDEF --apisecret 1234567890ABCDEF,
__service,worker2,worker  --host http://127.0.0.1:__port --instance 2 --apikey 1234567890ABCDEF --apisecret 1234567890ABCDEF,
__service,worker3,worker  --host http://127.0.0.1:__port --instance 3 --apikey 1234567890ABCDEF --apisecret 1234567890ABCDEF,
openqa-__service daemon))

ifelse(__service,worker1,`',__service,worker2,`',__service,worker3,`',__service,gru,`',OPENQA_BASE_PORT=__port )/usr/share/openqa/script/CMD >> __workdir/__service/.cout 2>> __workdir/__service/.cerr &
pid=$!
echo $pid > __workdir/__service/.pid
ifelse(__service,ui,
echo "Waiting (pid $pid) at http://127.0.0.1:__port"
while kill -0 $pid 2>/dev/null ; do
    { ( curl --max-time 2 -sI http://127.0.0.1:__port | grep 200 ) && break; } || :
    sleep 1
    echo -n .
done,`')

ifelse(__service,ui,
( # it is hassle to call it on every setup, so let's do it on every start
__workdir/db/sql "insert into users(username, email, fullname, nickname, is_operator, is_admin, feature_version, t_created, t_updated) values ('Demo','demo@user.org', 'Demo User', 'Demo', 1, 1, 1, now(), now()) on conflict do nothing"
__workdir/db/sql "insert into api_keys(key, secret, user_id, t_created, t_updated) values ('1234567890ABCDEF','1234567890ABCDEF', 2, now(), now()) on conflict do nothing"
) > /dev/null,`'
)

__workdir/__service/status
