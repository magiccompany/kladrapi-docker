#!/usr/bin/env bash
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if_error_echo () {
    if [ $? -gt 0 ];then
		echo $1
		exit 1
	fi
}

cd ..; mkdir tmp; cd tmp
curl -s "https://www.gnivc.ru/html/gnivcsoft/KLADR/Base.7z" > kladr.7z
if_error_echo "load archive is failed"

7z e -y kladr.7z && rm kladr.7z
if_error_echo "extracting failed"

dbf2csv -o ../files && cd .. && rm -rf tmp

php -f loader/index.php
if_error_echo "executing php script failed"
