set -euo pipefail
# test configures apache with the openqa config file, then checks that simplest http and https requests work

# apache environ + ssl
ap=$(environ ap)
$ap/configure_add_https
echo '
LoadModule mime_module           /usr/lib64/apache2-prefork/mod_mime.so
LoadModule headers_module        /usr/lib64/apache2-prefork/mod_headers.so
LoadModule expires_module        /usr/lib64/apache2-prefork/mod_expires.so
LoadModule proxy_module          /usr/lib64/apache2-prefork/mod_proxy.so
LoadModule proxy_http_module     /usr/lib64/apache2-prefork/mod_proxy_http.so
LoadModule proxy_http2_module    /usr/lib64/apache2-prefork/mod_proxy_http2.so
LoadModule proxy_wstunnel_module /usr/lib64/apache2-prefork/mod_proxy_wstunnel.so
LoadModule rewrite_module        /usr/lib64/apache2-prefork/mod_rewrite.so
LoadModule env_module            /usr/lib64/apache2-prefork/mod_env.so
' >> $ap/httpd.conf

# openqa environ
qa=$(environ qa $PWD)

address=$($qa/print_address)
port=${address#*:}

sed "s,/var/lib/openqa/share,$qa/openqa/share," etc/apache2/vhosts.d/openqa-common.inc | \
    sed "s,/var/lib/openqa/share/factory,$qa/openqa/share/factory," | \
    sed "s,/usr/share/openqa/public,$qa/openqa/share," | \
    sed "s,localhost:9526,127.0.0.1:$port," | \
    sed "s,localhost:9527,127.0.0.1:$((port+1))," | \
    sed "s,localhost:9528,127.0.0.1:$((port+2))," > $ap/dir.conf

$ap/start
$ap/status
$qa/start

$ap/curl /tests -I | grep '200 OK'
$ap/curl_https /tests -I | grep '200 OK'

curl -sI $($ap/print_address)/tests | grep '200 OK'

rc=0
curl -sI https://$($ap/print_address_https)/tests 2>/dev/null || rc=$?
# https connection will fail without certificate
test $rc -gt 0

curl -skI https://$($ap/print_address_https)/tests | grep '200 OK'

curl --cacert ca/ca.pem -sI https://$($ap/print_address_https)/tests | grep '200 OK'
