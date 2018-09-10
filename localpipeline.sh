#!/usr/bin/env bash

# localpipeline.sh
#
# bash file
# makes testing GitLab pipelines on a local machine easier
# by passing AWS credentials and SSH_PRIVATE keys straight into the executor
#
# This is dangerous and should only be used on development machines where
# execution and pipeline code is trusted.
#
# Invoke with "./localpipeline.sh {STAGE_NAME}"


AWS_CREDENTIALS=`cat ~/.aws/credentials`
SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa`
gitlab-runner exec docker --env "AWS_CREDENTIALS=$AWS_CREDENTIALS" --env "SSH_PRIVATE_KEY=$SSH_PRIVATE_KEY" $1
