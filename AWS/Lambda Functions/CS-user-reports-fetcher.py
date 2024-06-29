import json
import boto3
from custom_encoder import CustomEncoder


dynamoDB = boto3.resource('dynamodb')
userTable = dynamoDB.Table("CS-Users") 
reportTable = dynamoDB.Table("CS-Reports")

def lambda_handler(event, context):
    toBeReturned = []
    userEmail = event['queryStringParameters']['email']
    for report in reportTable.scan()["Items"]:
        if report['userEmail'] == userEmail:
            toBeReturned.append(report)
    return buildResponse(200, toBeReturned)


def buildResponse(statusCode, body=None):
    response = {
        'statusCode': statusCode,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        }
    }
    if body is not None:
        response['body'] = json.dumps(body, cls=CustomEncoder)

    return response
