# README

This is a Rails application with Cloud Memorystore connection settings from Cloud Run managed.

# Deploy

From building a container image to deploying it to Cloud Run, you can do the following.

## Container build

The first step is to install the beta command, as of May 17, 2020, the connection option from Cloud Run to Cloud Memorystore is for beta.

```sh
$ gcloud components install --quiet beta
```

Next, we will enable the build of this Rails container image to use Kaniko.

```sh
$ gcloud config set builds/use_kaniko True
```

Finally, to build the container image, execute the command of Cloud Build, because the configuration of Cloud Build needs the specific configuration of `cloudbuild.yml`.

```sh
$ gcloud builds submit --project <Google Cloud Platform Project ID> --config ./cloudbuild.yml
```

## Deploy to Cloud Run

You can connect to Cloud Memorystore from Cloud Run by running the command to deploy to Cloud Run. The important option for this command is to specify `-vpc-connector`, which is the serverless VPC access connector created from Cloud Run. By specifying this, you can connect to a Cloud Memorystore instance set to `REDIS_HOST`.

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
