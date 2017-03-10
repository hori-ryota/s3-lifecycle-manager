#!/bin/bash

set -e

dir='json'
backupDir='backup'

bucket=$1

if [ -z "$bucket" ]; then
	echo "Usage:" 1>&2
	echo '  ./update.sh ${bucket}' 1>&2
	exit 1
fi

jsonPath="$dir/$bucket.json"

if [ ! -e $jsonPath ]; then
	echo "json file not found [$jsonPath]"
	exit 1
fi

lastModifiedTime=$(date)

mkdir -p $backupDir
cp $jsonPath "$backupDir/${bucket}_${lastModifiedTime}"

dstJson=`cat $jsonPath | jq -r '{ LifecycleConfiguration: . }'`

aws s3api put-bucket-lifecycle-configuration --bucket "$bucket" --cli-input-json "$dstJson"
