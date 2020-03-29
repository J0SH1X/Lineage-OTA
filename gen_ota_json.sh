d=`date +%Y%m%d`
md5=`md5sum ../out/target/product/judyln/lineage-17.1-${d}-UNOFFICIAL-judyln.zip`

#Debugging im not good with shell scripts
echo ${d}
echo ${md5}

#This is where the magic happens

sed -i "s!lineage-17.1-20200339-UNOFFICIAL-judyln.zip!lineage-17.1-${d}-UNOFFICIAL-judyln.zip!" judyln.json
sed -i "s!
