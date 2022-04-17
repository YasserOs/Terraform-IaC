import os.path
import boto3
import email
from botocore.exceptions import ClientError
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

s3 = boto3.client("s3")

def lambda_handler(event, context):
    KEY = str(event["Records"][0]['s3']['object']['key'])
    FILE_NAME = os.path.basename(KEY)
    which_workspace = KEY.split("/")
    client = boto3.client('ses',region_name="eu-west-1")
    msg = MIMEMultipart()
    msg['Subject'] = "UPDATE ALERT"
    msg['From'] = "yasserosm.yo@gmail.com"
    msg['To'] = "yassoussama@yahoo.com"
    
    textpart = MIMEText( "Some changes happened in  " + which_workspace[1] + "  Workspace" )
    msg.attach(textpart)
    
    try:
        response = client.send_raw_email(
            Source="yasserosm.yo@gmail.com",
            Destinations=["yassoussama@yahoo.com"],
            RawMessage={ 'Data':msg.as_string() }
        )
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("Email sent! Message ID:",response['MessageId'])