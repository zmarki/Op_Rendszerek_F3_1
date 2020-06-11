#!/bin/bash

if ! [ -r $1 ]; then
        echo "nem olvashato a fájl"
        exit 100
fi

evek=(2017 2018)

if test -f stat.log.txt; then
	rm stat.log.txt
fi

if test -f avg.log; then
	rm avg.log
fi

for year in ${evek[*]}
do
	for honap in {01..12}
	do
		if expr `grep -c "$year-$honap" $1` > 0; then
			ferfi=`grep "$year-$honap" $1 | grep -c -e ",Male,"`
			no=`grep "$year-$honap" $1 | grep -c -e ",Female,"`
			mail=`grep "$year-$honap" $1 | grep -c -i -e "\.com," -e "\.co\.jp,"`
			A=`grep "$year-$honap"  $1 | grep -c -e "^[1-9]\." -e "^[1-9][0-9]\." -e ^1[0-1][0-9]\. -e ^12[0-6]\.`
			B=`grep "$year-$honap" $1 | grep -c -e ^12[8-9]\. -e ^1[3-8][0-9]\. -e ^190\. -e ^191\..*[^^191\.255\.] -e ^191\.255\.0\.0`
			C=`grep "$year-$honap" $1 | grep -c -e ^19[2-9]\. -e ^2[0-1][0-9]\. -e^22[0-2]\. -e ^223\..*[^^223.255.255\.]`
			echo $year-$honap: $no/$ferfi - $mail db - A: $A - B: $B - C: $C >> stat.log.txt
			sum=$(expr $A + $B + $C)
			avg=$(expr $sum / 3)
			echo $year-$honap: $avg >> avg.log 
		fi
	done
done

