#!/bin/bash

BIN=$PREFIX/bin
mkdir -p $BIN
sed -i.bak 's/CPPFLAGS = /CPPFLAGS = $(CXXFLAGS) /' Makefile
make CPP=$CXX -j${CPU_COUNT}
cp samblaster $BIN
