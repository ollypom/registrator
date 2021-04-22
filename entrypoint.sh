#!/bin/sh

# Fetch the IP and start registrator
LOCAL_IP=$(curl  -s --connect-timeout 3 ${ECS_CONTAINER_METADATA_URI_V4}/taskWithTags | jq -r .ContainerInstanceTags.INSTANCE_IP)
INSTANCE_HOSTNAME=$(curl  -s --connect-timeout 3 ${ECS_CONTAINER_METADATA_URI_V4}/taskWithTags | jq -r .ContainerInstanceTags.INSTANCE_HOSTNAME)
if [ $? -eq 0 ]; then
  /bin/registrator -ip $LOCAL_IP -hostname $INSTANCE_HOSTNAME $@
else
  /bin/registrator $@
fi
