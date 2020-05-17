# README

これはCloud RunのマネージドからCloud Memorystoreの接続設定を実施したRailsアプリケーションです。

# Deploy

コンテナイメージのビルドからCloud Runへのデプロイまでを以下のように実施できます。

## Container build

```sh
$ gcloud components install --quiet beta
```

まずはbetaコマンドのインストールを行います。2020年5月17日現在Cloud RunからCloud Memorystoreへの接続オプションはbetaのためす。

```sh
$ gcloud config set builds/use_kaniko True
```

次にこのRailsを格納するコンテナイメージのビルドはKanikoを使用するため有効化します。

```sh
$ gcloud builds submit --project <Google Cloud Platform Project ID> --config ./cloudbuild.yml
```

最後にコンテナイメージをビルドするためにCloud Buildのコマンドを実行します。Cloud Buildの設定は `cloudbuild.yml` に固有の設定が必要なので必要に応じて修正して下さい。

## Deploy to Cloud Run

```sh
$ gcloud beta run deploy <your cloud run service name> \
  --image gcr.io/<Google Cloud Platform Project ID>/<Container Image Name>:latest \
  --vpc-connector <your serverless vpc access connector name> \
  --platform managed \
  --region asia-northeast1 \
  --allow-unauthenticated \
  --set-env-vars RAILS_ENV=production \
  --set-env-vars RAILS_MASTER_KEY=<your Rails master key> \
  --set-env-vars REDIS_HOST=<your Cloud Memorystore instance host ip> \
  --set-env-vars REDIS_PORT=6379
```

最後にCloud Runにデプロイするコマンドを実行すればCloud RunからCloud Memorystoreに接続することができます。このコマンドで重要なオプションは `--vpc-connector` を指定し、Cloud Runから作成したサーバーレスVPCアクセスコネクタを指定することです。これを指定することで `REDIS_HOST` に設定するCloud Memorystoreのインスタンスに接続することが可能でうｓ．
