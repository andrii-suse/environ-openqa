( cd __workdir/src
tools/generate-packed-assets || tools/generate-packed-assets || tools/generate-packed-assets || :
[ ! -d __srcdir/../os-autoinst ] || [ -e  __src/os-autoinst ] || ln -s __srcdir/../os-autoinst __workdir/os-autoinst

# create folders which will be shared between all qa environs and link them from this environ
mkdir -p __workdir/../share/iso
mkdir -p __workdir/../share/hdd
mkdir -p __workdir/openqa/share/factory/
ln -sfn __workdir/../share/iso __workdir/openqa/share/factory/iso
ln -sfn __workdir/../share/hdd __workdir/openqa/share/factory/hdd
mkdir -p __workdir/openqa/testresults
mkdir -p __workdir/openqa/share/demo
)
