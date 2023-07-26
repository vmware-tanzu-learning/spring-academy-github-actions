Deploy Penguin Content
=======================

This GitHub action supports deploy all the penguin courses and guides
in an accompanying repository to the designated penguin environment
pointed to by the follow credentials:

- `PENGUINCTL_APIURL`
- `PENGUINCTL_APITOKEN`

There is no intelligence in the action about versions,
tags, or environments.

That is left to the author of the associated workflows consuming this
action.

The following are examples of handling staging and production deployments:

## Staging

Spring Academy current uses a strategy of trunk-based development -
developer pushes changes to main,
and the changes are immediately deployed to staging environment:

```yaml
name: "Deploy to Penguin Staging"
run-name: Deploy Penguin Content and Metadata from ${{ github.ref_name }} to Staging

on:
  push:
    branches:
      - main

jobs:
  build:
    name: Deploy to Penguin Staging
    environment: staging
    runs-on: ubuntu-latest
    steps:
      - name: Deploy Penguin Content
        uses: vmware-tanzu-learning/spring-academy-github-actions/deploy-content@v1
        with:
          penguin-api-url: ${{secrets.PENGUINCTL_APIURL}}
          penguin-api-token: ${{secrets.PENGUINCTL_APITOKEN}}
```

Note that the `staging` environment must be configured with the associated
penguin `PENGUINCTL_APIURL` and `PENGUINCTL_APITOKEN` credentials.

Or, if you are not entitled to use Github Environments,
you can use arbitrary environment variable names if you need multiple workflows to
configure multiple environments.

## Production

Spring Academy current uses a strategy of semantic versioning -
a release manager tags a commit in the content repository,
and the content at that commit is deployed the production penguin
environment:

```yaml
name: "Deploy to Penguin Production"
run-name: Deploy Penguin Content and Metadata from ${{ github.ref_name }} to Production

on:
  push:
    tags:
    - "v[0-9]+.[0-9]+.[0-9]+**"

jobs:
  build:
    name: Deploy to Penguin Production
    environment: production
    runs-on: ubuntu-latest
    steps:
      - name: Deploy Penguin Content
        uses: vmware-tanzu-learning/spring-academy-github-actions/deploy-content@v1
        with:
          penguin-api-url: ${{secrets.PENGUINCTL_APIURL}}
          penguin-api-token: ${{secrets.PENGUINCTL_APITOKEN}}
```

Note that the `production` environment must be configured with the associated
penguin `PENGUINCTL_APIURL` and `PENGUINCTL_APITOKEN` credentials.

Or, if you are not entitled to use Github Environments,
you can use arbitrary environment variable names if you need multiple workflows to
configure multiple environments.