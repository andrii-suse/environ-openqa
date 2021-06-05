set -e
mkdir -p  __workdir/openqa/share/tests
mkdir -p __workdir/../share
[ -d __workdir/../share/os-autoinst-distri-opensuse ] || ( cd __workdir/../share && git clone --depth=1 https://github.com/os-autoinst/os-autoinst-distri-opensuse )
mkdir -p __workdir/openqa/share/tests
ln -sfn __workdir/../share/os-autoinst-distri-opensuse  __workdir/openqa/share/tests/opensuse

[ -d __workdir/../share/os-autoinst-distri-opensuse/products/opensuse/needles ] || {
    mkdir __workdir/../share/os-autoinst-distri-opensuse/products/opensuse/needles
    git clone --depth=1 https://github.com/os-autoinst/os-autoinst-needles-opensuse __workdir/../share/os-autoinst-distri-opensuse/products/opensuse/needles
}

