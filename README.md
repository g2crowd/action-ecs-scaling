# GitHub Action ECS Scaling #

This is a github action to scale ECS service.

## Inputs ##

* `account` (**Required**): AWS account id where ECS service is running.

* `role` : IAM role to assume for performing scaling.

* `region` : AWS region.

* `cluster` (**Required**): ECS cluster name.

* `service` (**Required**): ECS service name.

* `count` (**Required**): Number of ECS tasks to keep running.


## Environment Variables ##

* `AWS_ACCESS_KEY_ID` (**Required**): AWS Access Key ID.

* `AWS_SECRET_ACCESS_KEY` (**Required**): AWS Secret Access Key.


## Example Usage ##

```yaml
on:
  push:
    branches:
      - main

  jobs:
    ecs_scaling:
      runs-on: ubuntu-18.04
      steps:
      - name: Staging Fatmongoose Worker
        uses: g2crowd/actions-ecs-scaling@main
        with:
          account: 683046045338
          cluster: fatmongoose-fargate-cluster
          service: staging_fatmongoose_worker
          count: 2
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```
