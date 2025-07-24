#!/bin/sh

prefix=/opt/unified-monitoring-agent/embedded
exec_prefix=/opt/unified-monitoring-agent/embedded
libdir=${exec_prefix}/lib

LD_PRELOAD=${libdir}/libjemalloc.so.2
export LD_PRELOAD
exec "$@"
