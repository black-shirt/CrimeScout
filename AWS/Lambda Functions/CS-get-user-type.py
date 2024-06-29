import json
import boto3

dynamoDB = boto3.resource('dynamodb')
userTable = dynamoDB.Table("CS-Users") 

def lambda_handler(event, context):
    userEmail = event['queryStringParameters']['email']
    userType = userTable.get_item(
        Key = {
            'email': userEmail
        }
     )["Item"]["userType"]
    
    
    return {
        'statusCode': 200,
        'body': json.dumps({'type': userType})
    }
