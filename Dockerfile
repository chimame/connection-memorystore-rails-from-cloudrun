FROM ruby:2.7.1-alpine

RUN apk add --no-cache tzdata sqlite-dev && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN mkdir /app
WORKDIR /app

ARG BUNDLE_OPTIONS

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN apk add --no-cache --virtual .rails-builddeps alpine-sdk && \
  bundle install -j4 ${BUNDLE_OPTIONS} && \
  apk del .rails-builddeps

COPY . /app

CMD ["bin/start"]
