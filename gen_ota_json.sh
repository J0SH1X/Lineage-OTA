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

cd ../device/lge/sdm845-common/ && git log > ~/los/Lineage-OTA/changelog.md.tmp && cd ~/los/Lineage-OTA/ && echo "########################################" > changelog.md && echo "COMMON CHANGES" >> changelog.md && echo "########################################" >> changelog.md && echo " " >> changelog.md && head -40 changelog.md.tmp >> changelog.md && echo "########################################" >> changelog.md && rm changelog.md.tmp && echo " " >> changelog.md && echo "########################################" >> changelog.md && echo "DEVICE CHANGES" >> changelog.md && echo "########################################" >> changelog.md && echo " " >> changelog.md && cd ../device/lge/judyln && git log > ~/los/Lineage-OTA/changelog.md.tmp && cd ~/los/Lineage-OTA/ && head -40 changelog.md.tmp >> changelog.md && echo "########################################" >> changelog.md && rm changelog.md.tmp && echo " " >> changelog.md && echo "########################################" >> changelog.md && echo "KERNEL CHANGES ########" >> changelog.md && echo "########################################" >> changelog.md && echo " " >> changelog.md && cd ../kernel/lge/sdm845 && git log > ~/los/Lineage-OTA/changelog.md.tmp && cd ~/los/Lineage-OTA && head -40 changelog.md.tmp >> changelog.md && echo "########################################" >> changelog.md && rm changelog.md.tmp


sed -i "s!${oldmd5}! \"${md5}\",!g" judyln.json
sed -i "s!${oldutc}! \"${utc}\",!g" judyln.json
sed -i "s!${oldsize}! \"${size}\",!g" judyln.json
sed -i "s!${oldd}!${d}!" judyln.json
sed -i "s!${url}!${d}!" judyln.json



rm -rf ~/web/*
mv ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip ~/web/
git add judyln.json
git add changelog.md
git commit -m "new release"
git push -u origin master
