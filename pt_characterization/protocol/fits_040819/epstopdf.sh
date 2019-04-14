#!/bin/bash
for i in *.eps
do
   echo "Welcome $i"
   `epstopdf $i`
   `rm -rf $i`
done

