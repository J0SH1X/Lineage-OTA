#!/bin/bash

d=$(date +%Y%m%d)
oldd=$(cat judyln.json | grep filename | cut -d '-' -f 3)
md5=$(md5sum ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip | cut -d ' ' -f 1)
oldmd5=$(cat judyln.json | grep '"id"' | cut -d':' -f 2)
utc=$(cat ../out/target/product/judyln/system/build.prop | grep ro.build.date.utc | cut -d '=' -f 2)
oldutc=$(cat judyln.json | grep datetime | cut -d ':' -f 2)
size=$(wc -c ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip | cut -d ' ' -f 1)
oldsize=$(cat judyln.json | grep size | cut -d ':' -f 2)
oldurl=$(cat judyln.json | grep url | cut -d ' ' -f 8)

#This is where the magic happens


sed -i "s!${oldmd5}! \"${md5}\",!g" judyln.json
sed -i "s!${oldutc}! \"${utc}\",!g" judyln.json
sed -i "s!${oldsize}! \"${size}\",!g" judyln.json
sed -i "s!${oldd}!${d}!" judyln.json
echo Enter the new Download URL
read -r url
sed -i "s!${oldurl}! \"${url}\",!g" judyln.json
