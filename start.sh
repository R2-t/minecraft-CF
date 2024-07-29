#!/bin/bash

INSTANCE_TAG_VALUE="MinecraftInstance"
INSTANCE_TAG="Project"
PROFILE=""

INSTANCE_ID=$(aws ec2 describe-instances --profile $PROFILE --filters "Name=instance-state-name,Values=stopped" "Name=tag:$INSTANCE_TAG,Values=$INSTANCE_TAG_VALUE" --query "Reservations[*].Instances[*].{InstanceId:InstanceId}" --output text)

if [ -n "$INSTANCE_ID" ]; then
    aws ec2 start-instances --profile $PROFILE --instance-ids $INSTANCE_ID 2>&1
else
    echo "There is no EC2 instance matching the filters"
fi
