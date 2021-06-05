(
# create folders which will be shared between all qa environs and link them from this environ
mkdir -p __workdir/../share/iso
mkdir -p __workdir/../share/hdd
mkdir -p __workdir/openqa/share/factory/
ln -sfn __workdir/../share/iso __workdir/openqa/share/factory/iso
ln -sfn __workdir/../share/hdd __workdir/openqa/share/factory/hdd
mkdir -p __workdir/openqa/testresults
mkdir -p __workdir/openqa/share/demo
)
