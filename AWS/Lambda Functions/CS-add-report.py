import json
import boto3
from custom_encoder import CustomEncoder

dynamoDB = boto3.resource('dynamodb')
table = dynamoDB.Table("CS-Reports") 


def lambda_handler(event, context):
    requestBody = json.loads(event['body'])
    table.put_item(Item=requestBody)
    body = {
        "Operation": "SAVE",
        "Message": "SUCCESS",
        "Item": requestBody
    }
    return buildResponse(200, body)


def buildResponse(statusCode, body=None):
    response = {
        'statusCode': statusCode,
        'headers': {
            'Content-Type': 'application/json',
            "access-control-allow-origin": "*"
        }
    }
    if body is not None:
        response['body'] = json.dumps(body, cls=CustomEncoder)

    return response
