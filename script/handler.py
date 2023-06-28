import json
import boto3
import os
import json

TAGS_TO_APPLY = os.environ.get('TAGS_TO_APPLY')

def lambda_handler(event, context):
    InstanceList = []
    client = boto3.client('ec2')
    ec2 = boto3.resource('ec2')
    resource_id = event['instance-id']
    tag = client.describe_tags(
        Filters=[
            {
                'Name': 'tag:DoNotTag',
                'Values': [
                    'True',
                ]
            },
        ])
    for t in tag['Tags']:
        InstanceList.append(t['ResourceId'])
    if resource_id in InstanceList:
        print("DoNotTag", resource_id)
    else:
        response = client.create_tags(
            Resources=[
                resource_id,
            ],
            Tags=json.loads(TAGS_TO_APPLY)
        )
        response = client.create_tags(
            Resources=[
                resource_id,
            ],
            Tags=[{
                    'Key': 'DoNotTag',
                    'Value': 'True'
                }]
        )
        print(resource_id, "Tagged")


