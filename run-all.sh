#!/usr/bin/env bash

folder="output-$(date +%Y%m%d%H%M%S)"
mkdir $folder

benchy run --keep-logs -v --ndjson=$folder/channel-primes.ndjson channel-primes/run.yaml
benchy run --keep-logs -v --ndjson=$folder/matmul.ndjson matmul/run.yaml
benchy run --keep-logs -v --ndjson=$folder/matmul-channel.ndjson matmul-channel/run.yaml
benchy run --keep-logs -v --ndjson=$folder/hello-world-http-server.ndjson hello-world-http-server/run.yaml
benchy run --keep-logs -v --ndjson=$folder/hello-world-db-http-server.ndjson hello-world-db-http-server/run.yaml
benchy run --keep-logs -v --ndjson=$folder/compile.ndjson compile/run.yaml
