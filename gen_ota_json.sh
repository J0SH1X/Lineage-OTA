#!/bin/bash

d=$(date +%Y%m%d)
oldd=$(grep filename judyln.json | cut -d '-' -f 3)
md5=$(md5sum ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip | cut -d ' ' -f 1)
oldmd5=$(grep '"id"' judyln.json | cut -d':' -f 2)
utc=$(grep ro.build.date.utc ../out/target/product/judyln/system/build.prop | cut -d '=' -f 2)
oldutc=$(grep datetime judyln.json | cut -d ':' -f 2)
size=$(wc -c ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip | cut -d ' ' -f 1)
oldsize=$(grep size judyln.json | cut -d ':' -f 2)
url=$(grep url judyln.json | cut -d '-' -f 3)

#This is where the magic happens


sed -i "s!${oldmd5}! \"${md5}\",!g" judyln.json
sed -i "s!${oldutc}! \"${utc}\",!g" judyln.json
sed -i "s!${oldsize}! \"${size}\",!g" judyln.json
sed -i "s!${oldd}!${d}!" judyln.json
sed -i "s!${url}!${d}!" judyln.json

rm -rf ~/web/*
mv ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip ~/web/
git add judyln.json
git commit -m "new release"
git push -u origin master
