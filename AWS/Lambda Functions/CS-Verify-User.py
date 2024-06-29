import json
import boto3

dynamoDB = boto3.resource('dynamodb')
userTable = dynamoDB.Table("CS-Users") 

def lambda_handler(event, context):
    
    userEmail = event['queryStringParameters']['email']
    print(event['queryStringParameters'])
    for user in userTable.scan()["Items"]:
        if user['email'] == userEmail:
            return {
                'statusCode': 200,
                'body': json.dumps({'isVerified':"T"})
            }
    return {
        'statusCode': 200,
        'body': json.dumps({'isVerified':"F"})
    }
            
