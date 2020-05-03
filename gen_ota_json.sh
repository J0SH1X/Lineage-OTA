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

cd ../device/lge/sdm845-common/ && git log > ~/los/Lineage-OTA/changelog.txt.tmp && cd ~/los/Lineage-OTA/ && echo "########################################" > changelog.txt && echo "COMMON CHANGES" >> changelog.txt && echo "########################################" >> changelog.txt && echo " " >> changelog.txt && head -40 changelog.txt.tmp >> changelog.txt && echo "########################################" >> changelog.txt && rm changelog.txt.tmp && echo " " >> changelog.txt && echo "########################################" >> changelog.txt && echo "DEVICE CHANGES" >> changelog.txt && echo "########################################" >> changelog.txt && echo " " >> changelog.txt && cd ../device/lge/judyln && git log > ~/los/Lineage-OTA/changelog.txt.tmp && cd ~/los/Lineage-OTA/ && head -40 changelog.txt.tmp >> changelog.txt && echo "########################################" >> changelog.txt && rm changelog.txt.tmp && echo " " >> changelog.txt && echo "########################################" >> changelog.txt && echo "KERNEL CHANGES" >> changelog.txt && echo "########################################" >> changelog.txt && echo " " >> changelog.txt && cd ../kernel/lge/sdm845 && git log > ~/los/Lineage-OTA/changelog.txt.tmp && cd ~/los/Lineage-OTA && head -40 changelog.txt.tmp >> changelog.txt && echo "########################################" >> changelog.txt && rm changelog.txt.tmp && cd ../device/lge/common/ && git log > ~/los/Lineage-OTA/changelog.txt.tmp && cd ~/los/Lineage-OTA/ && echo "########################################" > changelog.txt && echo "LGE COMMON CHANGES" >> changelog.txt && echo "########################################" >> changelog.txt && echo " " >> changelog.txt && head -40 changelog.txt.tmp >> changelog.txt && echo "########################################" >> changelog.txt && rm changelog.txt.tmp


sed -i "s!${oldmd5}! \"${md5}\",!g" judyln.json
sed -i "s!${oldutc}! \"${utc}\",!g" judyln.json
sed -i "s!${oldsize}! \"${size}\",!g" judyln.json
sed -i "s!${oldd}!${d}!" judyln.json
sed -i "s!${url}!${d}!" judyln.json



rm -rf ~/web/*
cp ../out/target/product/judyln/lineage-17.1-"${d}"-UNOFFICIAL-judyln.zip ~/web/
cp changelog.txt ~/web/
cp judyln.json ~/web/.judyln.json
#git add judyln.json
#git add changelog.txt
#git commit -m "new release"
#git push -u origin master
