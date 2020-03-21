#!/bin/sh

# copywrite by Johannes 'Banana' Keßler 2020

# this example show how to search multiple repos in the current
# directory. Use this to create your own command and search.

for d in */; do
  git -C "$d" --no-pager rev-list --all | xargs git -C "$d" --no-pager grep -l SEARCHTERM >> search.log;
done;