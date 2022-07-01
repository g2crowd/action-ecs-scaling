#!/bin/sh -l

ACCOUNT=$1
ROLE=$2
REGION=$3
CLUSTER=$4
SERVICE=$5
COUNT=$6

ROLE_ARN="arn:aws:iam::$ACCOUNT:role/$ROLE"
echo "Assuming IAM role: $ROLE_ARN"
AWS_CREDENTIALS=$(aws --region $REGION sts assume-role --role-arn $ROLE_ARN --role-session-name "ACTION-ECS-SCALING")
export AWS_ACCESS_KEY_ID=$(echo $AWS_CREDENTIALS|jq '.Credentials.AccessKeyId'|tr -d '"')
export AWS_SECRET_ACCESS_KEY=$(echo $AWS_CREDENTIALS|jq '.Credentials.SecretAccessKey'|tr -d '"')
export AWS_SESSION_TOKEN=$(echo $AWS_CREDENTIALS|jq '.Credentials.SessionToken'|tr -d '""')

CURRENT_COUNT=$(aws --region $REGION ecs describe-services --cluster $CLUSTER --services $SERVICE | jq -r '.services[0].desiredCount')
echo "Current running tasks: $CURRENT_COUNT"
echo "Requested task count: $COUNT"

if [ "$CURRENT_COUNT" != "$COUNT" ]; then
  echo "Updating tasks scale"
  aws --region $REGION ecs update-service --cluster $CLUSTER --service $SERVICE --desired-count $COUNT
fi
