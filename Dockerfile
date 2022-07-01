FROM amazon/aws-cli:2.0.6

LABEL "com.github.actions.name"="ECS Scaling GitHub Action"
LABEL "com.github.actions.description"="This is a github actions to scale ECS service."
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="green"

WORKDIR /opt/app

COPY . .

RUN yum install jq -y && chmod +x entrypoint.sh

ENTRYPOINT ["/opt/app/entrypoint.sh"]
