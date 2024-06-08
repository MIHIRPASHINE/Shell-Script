##########################
#Write a shell's script to report the usage of aws resources (EC2 instances, S3 buckets, Lambda functions, IAM Users) in your project.

#It is a common practice for devops engineers to report the AWS resources usage to manager at the EOD.
#Ideally, they supply all the usage info to reporting dashboard, but in today's case scenerio we are saving the info in a usage-report-file and presenting it to manager.

#!/bin/bash

##################
#AUTHOR: MIHIR
#DATE:08/03/24
#VERSION: V1
#
#PURPOSE: THIS SCRIPT WILL REPORT THE AWS RESOURCE USAGE
#####################
set -e #exit the script in case of error
#
report_date=$(date +'%Y-%m-%d_%H-%M-%S')
filename="usage-report-file_$report_date"
#
#list S3 buckets
echo "1.) following is the list of s3 buckets" >> "$filename"
aws s3 ls >> "$filename"

#list ec2 instances  #ensure that jq is installed #sudo yum -y install jq
echo "2.) following is the list of ec2 instances" >> "$filename"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> "$filename"

#list lambda functions
echo "3.) following is the list of lambda functions" >> "$filename"
aws lambda list-functions >> "$filename"

#list IAM Users
echo "4.) following is the list of iam-users" >> "$filename"
aws iam list-users >> "$filename"

####################

