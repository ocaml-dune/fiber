#!/usr/bin/env bash
export BENCHMARKS_RUNNER=TRUE
case "$1" in
  "fiber" ) test="fiber_bench"; main="fiber_bench_main";;
esac
shift;
export BENCH_LIB="$test"
dir=$(dirname "$0")
exec dune exec --release -- "$dir/$main.exe" -fork -run-without-cross-library-inlining "$@"
