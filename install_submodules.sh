#!/bin/bash

cd Peano
git checkout p4

#awk '/AC_ARG_ENABLE/{x++}x{sub("withval", "enableval")&&x++&&x=(x==2)?0:x}1' configure.ac

# This may fail?
libtoolize
aclocal
autoconf
autoheader
cp src/config.h.in .
automake --add-missing

# Needed on some machines?
autoreconf -i

# Pass on all arguments?
# MacOS: CXX="g++" CXXFLAGS="-std=c++17"
./configure CXX="g++" CXXFLAGS="-std=c++17" --enable-exahype --enable-loadbalancing-toolbox

make
