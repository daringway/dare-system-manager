#!/usr/bin/env bash

chmod +x distribution/bin/* distribution/sbin/*
aws s3 sync --delete distribution s3://daring-packages/dare-sm/
#aws s3 sync --delete subscribers s3://daring-packages/subscribers