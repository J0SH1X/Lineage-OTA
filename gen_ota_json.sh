d=`date +%Y%m%d`
oldd=`cat judyln.json | grep filename | cut -d '-' -f 3`
md5=`md5sum ../out/target/product/judyln/lineage-17.1-${d}-UNOFFICIAL-judyln.zip | cut -d ' ' -f 1`
oldmd5=`cat judyln.json | grep '"id"' | cut -d':' -f 2`
utc=`cat ../out/target/product/judyln/system/build.prop | grep ro.build.date.utc | cut -d '=' -f 2`
oldutc=`cat judyln.json | grep datetime | cut -d ':' -f 2`

#Debugging im not good with shell scripts
echo ${d}
echo ${oldd}
echo ${md5}
echo ${oldmd5}
echo ${utc}
echo ${oldutc}
#This is where the magic happens


sed -i "s!${oldmd5}!"${md5}",!" judyln.json
sed -i "s!${oldutc}!"${utc}",!" judyln.json
sed -i "s!${oldd}!"${d}",!" judyln.json
