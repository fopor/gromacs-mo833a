cat ../../build/debug/bin/output.log | grep time | cut -d' ' -f 5 > debug_time
cat ../../build/release/bin/output.log | grep time | cut -d' ' -f 5 > release_time

