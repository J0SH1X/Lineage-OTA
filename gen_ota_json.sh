#!/bin/bash

DEVICE=$1


d=$(date +%Y%m%d)

VERSION=$(git rev-parse --abbrev-ref HEAD)
FILENAME="${VERSION}"-"${d}"-UNOFFICIAL-"${DEVICE}".zip


oldd=$(grep filename $DEVICE.json | cut -d '-' -f 3)
md5=$(md5sum ../out/target/product/$DEVICE/$FILENAME | cut -d ' ' -f 1)
oldmd5=$(grep '"id"' $DEVICE.json | cut -d':' -f 2)
utc=$(grep ro.build.date.utc ../out/target/product/$DEVICE/system/build.prop | cut -d '=' -f 2)
oldutc=$(grep datetime $DEVICE.json | cut -d ':' -f 2)
size=$(wc -c ../out/target/product/$DEVICE/$FILENAME | cut -d ' ' -f 1)
oldsize=$(grep size $DEVICE.json | cut -d ':' -f 2)
oldurl=$(grep url $DEVICE.json | cut -d ':' -f 3)
oldurl="\"https:${oldurl}"
devicerepopath=$(find ../device | grep -i ${DEVICE} | head  -1 | cut -d '.' -f 3)
manufacturer=$(echo $devicerepopath | cut -d '/' -f 3)
devicecommonrepo=$(cat ../$devicerepopath/BoardConfig.mk | grep -i 'common/Bo' | cut -d '/' -f 3)
deviceplatform=$(echo $devicecommonrepo | cut -d '-' -f1)
changelogdevicepath=device/$manufacturer/$DEVICE
changelogdevicecommonpath=device/$manufacturer/$devicecommonrepo
changelogkernelpath=kernel/$manufacturer/$deviceplatform
changelogvendorpath=vendor/$manufacturer
REPOS=(${changelogdevicepath} ${changelogdevicecommonpath} ${changelogkernelpath} ${changelogvendorpath})
GITORIGIN=$(git config --get remote.origin.url | cut -d '/' -f4)

# Generate the Changelog
# Clear the changelog file
echo "" > changelog.txt

for repo in ${REPOS[*]}
do
    echo "########################################" >> changelog.txt
    echo "${repo} Changes:" >> changelog.txt
    git --git-dir ../"${repo}"/.git log --since="${oldutc}" >> changelog.txt
done

echo "########################################" >> changelog.txt

#This is where the magic happens
sed -i "s!${oldmd5}! \"${md5}\",!g" $DEVICE.json
sed -i "s!${oldutc}! \"${utc}\",!g" $DEVICE.json
sed -i "s!${oldsize}! \"${size}\",!g" $DEVICE.json
sed -i "s!${oldd}!${d}!" $DEVICE.json
#echo Generate Download URL
TAG=$(echo "${DEVICE}-${d}")
url="https://github.com/${GITORIGIN}/Lineage-OTA/releases/download/${TAG}/${FILENAME}"
sed -i "s!${oldurl}!\"${url}\",!g" $DEVICE.json

git add $DEVICE.json
git add changelog.txt
git commit -m "Update ${DEVICE} to ${d}"
git push https://github.com/${GITORIGIN}/Lineage-OTA ${VERSION}

hub release create -a ../out/target/product/$DEVICE/$FILENAME -a changelog.txt -m "${TAG}" "${TAG}"

