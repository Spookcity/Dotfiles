#!/bin/sh
sed -i \
         -e 's/#0f161e/rgb(0%,0%,0%)/g' \
         -e 's/#a1bfc0/rgb(100%,100%,100%)/g' \
    -e 's/#0f161e/rgb(50%,0%,0%)/g' \
     -e 's/#2e534c/rgb(0%,50%,0%)/g' \
     -e 's/#0f161e/rgb(50%,0%,50%)/g' \
     -e 's/#a1bfc0/rgb(0%,0%,50%)/g' \
	"$@"
