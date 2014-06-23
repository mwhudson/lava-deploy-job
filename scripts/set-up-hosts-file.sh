#!/bin/bash
lava-network broadcast eth0
lava-network collect eth0
lava-group | python -c 'from collections import defaultdict
import sys

hostname2testname = {}
rolecounts = defaultdict(int)
for line in sorted(sys.stdin):
    hostname, role = line.strip().split()
    rolecounts[role] += 1
    testname = "%s%02d"%(role, rolecounts[role])
    print hostname + "\t" + testname
' | while read host testname; do
    echo $(lava-network query $host ipv4) $testname $host  >> /mnt/etc/hosts
done
