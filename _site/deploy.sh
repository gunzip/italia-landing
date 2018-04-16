#!/bin/bash -e

# Do not run this script outside CircleCI
test -n "$CIRCLE_USERNAME" || exit 1

ssh-keyscan -H github.com >> ~/.ssh/known_hosts
git config --global user.email "cittadinanzadigitale@italia.it"
git config --global user.name "$CIRCLE_USERNAME"
git checkout -B website
git add -f _site Dockerfile
git commit -m "[website update] v$CIRCLE_BUILD_NUM"
git push -f -u origin website:website
git tag -a website-v$CIRCLE_BUILD_NUM -m "[website update] v$CIRCLE_BUILD_NUM"
git push origin website-v$CIRCLE_BUILD_NUM
