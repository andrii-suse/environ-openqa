set -e
ln -sf __workdir/../os-autoinst/t/data/tests __workdir/../openqa/share/demo/
ln -sf __workdir/../os-autoinst/t/data/Core-7.2.iso __workdir/../openqa/share/factory/iso/
ln -sf __workdir/../os-autoinst/t/data/tests/needles __workdir/../openqa/share/

generate_data() {
    cat <<EOF
{
"ARCH" : "x86_64",
"ASSETDIR" : "__workdir/../openqa/share/factory",
"BACKEND" : "qemu",
"CASEDIR" : "__workdir/../openqa/share/demo/tests",
"INTEGRATION_TESTS" : "1",
"ISO" : "Core-7.2.iso",
"NEEDLES_DIR" : "__workdir/../openqa/share/needles",
"PRJDIR" : "__workdir/../openqa/share",
"PRODUCTDIR" : "__workdir/../openqa/share/demo/tests",
"QEMU" : "x86_64",
"QEMU_NO_FDC_SET" : "1",
"QEMU_NO_KVM" : "1",
"QEMU_NO_TABLET" : "1",
"TEST" : "demo",
"WORKER_HOSTNAME" : "127.0.0.1",
}
EOF
}

port=$((__wid * 10 + 9526))

generate_data > __workdir/param.json

__workdir/client --param __workdir/param.json --host http://127.0.0.1:__port --apikey 1234567890ABCDEF --apisecret 1234567890ABCDEF jobs post
