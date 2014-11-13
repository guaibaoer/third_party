#!/bin/bash

prefix=$(readlink -f $(dirname $0))
src=$prefix/src

# clean
if [[ $1 = "clean" ]]; then
  cd $prefix
  rm -rf bin/ include/ lib/ share/
  for i in $src/*/; do rm -rf $i; done
  exit
fi

cd $src
for tarball in *.tar.gz; do
  tar zxf $tarball
done

function standard_routine {
  ./configure --prefix=$prefix && make -j && make install
}

cd $src/glog*  && standard_routine
cd $src/gflag* && standard_routine
cd $src/gperf* && ./configure --prefix=$prefix --enable-frame-pointers && make -j && make install
cp -r $src/eigen*/Eigen $prefix/include/

