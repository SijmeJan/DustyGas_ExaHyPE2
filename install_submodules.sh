#!/bin/bash

cd Peano
git checkout p4

# All of the enable options seem to depend on 'withval' rather than 'enableval'.
# I am not an expert on autotools, but without replacing it fails to ever
# enable exahype etc.
awk '/AC_MSG_CHECKING\(for fem-toolbox/{print;getline;sub("withval", "enableval");print;next}1' configure.ac > tmp && mv tmp configure.ac
awk '/AC_MSG_CHECKING\(for multiprecision-toolbox/{print;getline;sub("withval", "enableval");print;next}1' configure.ac > tmp && mv tmp configure.ac
awk '/AC_MSG_CHECKING\(for loadbalancing-toolbox/{print;getline;sub("withval", "enableval");print;next}1' configure.ac > tmp && mv tmp configure.ac
awk '/AC_MSG_CHECKING\(for exahype/{print;getline;sub("withval", "enableval");print;next}1' configure.ac > tmp && mv tmp configure.ac

# Autoconf
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
