#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#0f161e/g' \
         -e 's/rgb(100%,100%,100%)/#a1bfc0/g' \
    -e 's/rgb(50%,0%,0%)/#0f161e/g' \
     -e 's/rgb(0%,50%,0%)/#2e534c/g' \
 -e 's/rgb(0%,50.196078%,0%)/#2e534c/g' \
     -e 's/rgb(50%,0%,50%)/#0f161e/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#0f161e/g' \
     -e 's/rgb(0%,0%,50%)/#a1bfc0/g' \
	"$@"
