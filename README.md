# S3 Lifecycle Manager

[hori\-ryota/cloudfront\-manager: Scripts for CloudFront](https://github.com/hori-ryota/cloudfront-manager) から派生して作りました。

S3のlifecycleをポチポチ運用するのが辛いのでawscliを用いたjson管理にするやつです。

## （基礎知識）主要なawsコマンド

[AWS CLI を使用したライフサイクル設定の設定 \- Amazon Simple Storage Service](http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/set-lifecycle-cli.html)

## ディレクトリ構成
```
targetBuckets.txt # 管理対象とするbucketリスト
json/             # apiから取得したjson置き場
```

更新はjsonディレクトリ内のファイルを更新してS3に反映してください。

## スクリプト

vim の quickrun で叩きやすくするため、dirname などでのパス解決はしていないです。 `s3-lifecycle-manager/` ディレクトリ直下で実行してください。

### [fetchall.sh](fetchall.sh)

初期化用。 `targetBuckets.txt` に記載されているbucketのlifecycleを取ってきてjsonディレクトリに反映。

削除済みのjson削除は行わないので、削除も必要ならjsonディレクトリを削除後に実行してください。

### [update.sh](update.sh)

```sh
$ ./update.sh ${targetCName}
```

更新用。`get-bucket-lifecycle-configuration` のjsonと `put-bucket-lifecycle-configuration` の形式は若干違うので、`jq` コマンドで整形したものを入力へ。

### 全bucketを targetBuckets.txt に入れたい場合

このコマンドで入るかと思います。

```sh
$ aws s3api list-buckets | jq -r '.Buckets[].Name' > targetBuckets.txt
```
