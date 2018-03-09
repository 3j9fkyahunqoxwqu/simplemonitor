#!/usr/bin/env bash

set -ex

rm -f network.log

# start the master instance
coverage run --append monitor.py -f tests/network/master/monitor.ini -d &
sleep 5

# run the client instance
COVERAGE_FILE=.coverage.2 coverage run --append monitor.py -f tests/network/client/monitor.ini -1 -d &

# let them run
sleep 25

# shut down the master instance
kill %1
kill %2

# make sure the client reached the master 
grep test2 network.log
