#!/bin/bash

set -eu

dir='json'
mkdir -p $dir

buckets="$(cat ./targetBuckets.txt)"

for bucket in $buckets; do
  echo "fetch $bucket"
  target=$(aws s3api get-bucket-lifecycle-configuration --bucket "$bucket")
  echo $target | jq '.' > "$dir/$bucket.json"
done
