#!/bin/sh

for file in $(ls *.v); do
  mv $file "${${file.%v}sv}"
done
