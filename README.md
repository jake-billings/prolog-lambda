# prolog-lambda
This repository is intended to demonstrate the feasibility of using Prolog to implement business logic in the oddly-specific use case of AWS microservice architecture with GitLab pipelines for continuous deployment.
## Working with this repository

All commands for this repository are run through the package manager `Yarn`. To get started, run `yarn install`.

### Commands
See `package.json` for current commands.

- `yarn lint` - Runs `eslint` for the project
- `yarn build` - Runs a complete build for the project (including docs and dist)
- `yarn build:docs` - Runs `apidoc` to generate html documentation in the `/docs` folder
- `yarn build:transpile` - Runs `babel` to compile `es6` to `node8` in the `/dist` folder
- `yarn test` - Runs `mocha` to run the automated tests for this repository
- `yarn test:health` - Runs `mocha` to run the automated tests for the health of remote deployed version on AWS (see `health/`)
- `yarn deploy` - Runs `yarn deploy:update` to update the lambda code on AWS
- `yarn deploy:create` - Runs `claudia` to create the lambda on AWS; this only ever needs to be run once in the lifetime of the project (unless you delete them lambda and role)
- `yarn deploy:update` - Runs `claudia` to update the lambda code on AWS

### Pipeline Stages

- Build - Build, Test, and Lint lamda to ensure it's deploy-ready. This stage deploys documentation using GitLab pages. (run on every commit)
- Deploy - Deploy the lambda to AWS using claudia (only runs on master)
- Health - Ensure that the lambda is running properly on AWS (only runs on master)

A note about the health check: the health check is intended only to be a small 1-2 check test that verifies the lambda is running on AWS. The build should fail if it took down the endpoint.

### Variables

This repository depends on the pipeline variable `$AWS_CREDENTIALS`. This should be a string in the same format as a typical AWS credential file from `~/.aws/credentials`. This must be configured in Pipelines for the deploy feature to work.

Ex:
```
[default]
aws_access_key_id={{get this from management console}}
aws_secret_access_key={{get this from management console}}
```

This repository also depends on the pipeline variable `$SSH_PRIVATE_KEY`. This should be an SSH key with read access any private library code, so that the build process can clone it from GitLab.

Ex:
```
-----BEGIN RSA PRIVATE KEY-----
PTki5G68S5NVpoQ47T0z38U4osYwj3DXS9t+VOgWvPTki5G68S5NVpo
XS9t+VOgWv/3wGio+gYV6Npb1w2Gh1RQZaVO/nmA6wM/6sS5eJnDxR2
...you get the idea
-----END RSA PRIVATE KEY-----