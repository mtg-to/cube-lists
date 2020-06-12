#!/bin/bash

cube="$1"

git show "origin/master:$cube.txt" | sort | uniq > .old.txt.tmp
cat "$cube.txt" | sort | uniq > .new.txt.tmp

cat >>CHANGELOG.md << EOF

## Update $(date +'%Y-%m-%d')

### Additions:

$(diff -u .old.txt.tmp .new.txt.tmp | sed -ne "s/^+1 \(.*\)$/ 1. \1/p")

### Removals:

$(diff -u .old.txt.tmp .new.txt.tmp | sed -ne "s/^-1 \(.*\)$/ 1. \1/p")

EOF

mv .new.txt.tmp "$cube.txt"
