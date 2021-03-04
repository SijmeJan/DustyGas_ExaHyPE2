#!/bin/bash

cd Peano
git checkout p4

# This may fail?
libtoolize
aclocal
autoconf
autoheader
cp src/config.h.in .
automake --add-missing
autoreconf -i

# Pass on all arguments?
# MacOS: CXX="g++" CXXFLAGS="-std=c++17"
./configure CXX="g++" CXXFLAGS="-std=c++17" --enable-exahype --enable-loadbalancing-toolbox

make
