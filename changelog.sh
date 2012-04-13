#!/bin/bash
currentMerge=$(git log --merges master -1 --format=%h)
previousMerge=$(git log --merges master -2 --format=%h | tail -n1)
git log ${previousMerge}..${currentMerge}
