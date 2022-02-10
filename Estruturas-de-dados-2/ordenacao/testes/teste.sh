#!/bin/bash
set -e

for src in *.c; do
	time tcc -run $src
	echo ''
done
