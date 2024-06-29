import json
import boto3

dynamoDB = boto3.resource('dynamodb')
reportTable = dynamoDB.Table("CS-Reports")  

def lambda_handler(event, context):
    
    reportID = event['queryStringParameters']['reportID']
    status = event['queryStringParameters']['status']
    
    reportTable.update_item(
            Key={
                'reportID': reportID
            },
            UpdateExpression=f'SET #a = :a',
            ExpressionAttributeValues={
                ':a': int(status),
            },
            ExpressionAttributeNames={
                '#a': 'status',
            },
            ReturnValues='ALL_NEW'
        )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
