#!/bin/bash
# AWS Automation Script
# Tự động hóa các tác vụ trên AWS

ACTION="$1"
REGION="${AWS_REGION:-us-east-1}"

usage() {
    echo "Usage: $0 {ec2-start|ec2-stop|s3-backup|rds-snapshot|lambda-deploy}"
    exit 1
}

# Check AWS CLI
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "Installing AWS CLI..."
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
    fi
}

# Start EC2 instances
ec2_start() {
    INSTANCE_IDS="$1"
    
    echo "Starting EC2 instances: $INSTANCE_IDS"
    
    aws ec2 start-instances --instance-ids $INSTANCE_IDS --region "$REGION"
    
    if [ $? -eq 0 ]; then
        echo "✓ Instances started"
        aws ec2 wait instance-running --instance-ids $INSTANCE_IDS --region "$REGION"
        echo "✓ Instances are now running"
    else
        echo "✗ Failed to start instances"
        exit 1
    fi
}

# Stop EC2 instances
ec2_stop() {
    INSTANCE_IDS="$1"
    
    echo "Stopping EC2 instances: $INSTANCE_IDS"
    
    aws ec2 stop-instances --instance-ids $INSTANCE_IDS --region "$REGION"
    
    if [ $? -eq 0 ]; then
        echo "✓ Instances stopped"
    else
        echo "✗ Failed to stop instances"
        exit 1
    fi
}

# Backup to S3
s3_backup() {
    SOURCE_DIR="$1"
    S3_BUCKET="$2"
    
    echo "Backing up $SOURCE_DIR to S3://$S3_BUCKET"
    
    aws s3 sync "$SOURCE_DIR" "s3://$S3_BUCKET/backups/$(date +%Y%m%d)/" \
        --exclude "*.tmp" \
        --exclude ".git/*" \
        --storage-class STANDARD_IA \
        --region "$REGION"
    
    if [ $? -eq 0 ]; then
        echo "✓ S3 backup completed"
    else
        echo "✗ S3 backup failed"
        exit 1
    fi
}

# Create RDS snapshot
rds_snapshot() {
    DB_INSTANCE="$1"
    SNAPSHOT_ID="$DB_INSTANCE-snapshot-$(date +%Y%m%d-%H%M%S)"
    
    echo "Creating RDS snapshot: $SNAPSHOT_ID"
    
    aws rds create-db-snapshot \
        --db-instance-identifier "$DB_INSTANCE" \
        --db-snapshot-identifier "$SNAPSHOT_ID" \
        --region "$REGION"
    
    if [ $? -eq 0 ]; then
        echo "✓ RDS snapshot created: $SNAPSHOT_ID"
    else
        echo "✗ RDS snapshot failed"
        exit 1
    fi
}

# Deploy Lambda function
lambda_deploy() {
    FUNCTION_NAME="$1"
    ZIP_FILE="$2"
    RUNTIME="${3:-python3.9}"
    HANDLER="${4:-lambda_function.lambda_handler}"
    ROLE_ARN="$5"
    
    echo "Deploying Lambda function: $FUNCTION_NAME"
    
    # Check if function exists
    if aws lambda get-function --function-name "$FUNCTION_NAME" --region "$REGION" 2>/dev/null; then
        # Update existing function
        aws lambda update-function-code \
            --function-name "$FUNCTION_NAME" \
            --zip-file "fileb://$ZIP_FILE" \
            --region "$REGION"
    else
        # Create new function
        aws lambda create-function \
            --function-name "$FUNCTION_NAME" \
            --runtime "$RUNTIME" \
            --role "$ROLE_ARN" \
            --handler "$HANDLER" \
            --zip-file "fileb://$ZIP_FILE" \
            --region "$REGION"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✓ Lambda function deployed"
    else
        echo "✗ Lambda deployment failed"
        exit 1
    fi
}

# List resources
aws_list_resources() {
    echo "AWS Resources in region: $REGION"
    echo "================================="
    
    echo -e "\nEC2 Instances:"
    aws ec2 describe-instances \
        --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key==`Name`].Value|[0]]' \
        --output table \
        --region "$REGION"
    
    echo -e "\nS3 Buckets:"
    aws s3 ls
    
    echo -e "\nRDS Instances:"
    aws rds describe-db-instances \
        --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,Engine]' \
        --output table \
        --region "$REGION"
}

# Cost report
aws_cost_report() {
    START_DATE=$(date -d "1 month ago" +%Y-%m-%d)
    END_DATE=$(date +%Y-%m-%d)
    
    echo "AWS Cost Report: $START_DATE to $END_DATE"
    echo "=========================================="
    
    aws ce get-cost-and-usage \
        --time-period Start="$START_DATE",End="$END_DATE" \
        --granularity MONTHLY \
        --metrics "UnblendedCost" \
        --group-by Type=DIMENSION,Key=SERVICE \
        --region us-east-1
}

# Main
check_aws_cli

case "$ACTION" in
    ec2-start)
        ec2_start "i-1234567890abcdef0"
        ;;
    ec2-stop)
        ec2_stop "i-1234567890abcdef0"
        ;;
    s3-backup)
        s3_backup "/var/www" "my-backup-bucket"
        ;;
    rds-snapshot)
        rds_snapshot "my-database"
        ;;
    lambda-deploy)
        lambda_deploy "my-function" "function.zip" "python3.9" "lambda_function.lambda_handler" "arn:aws:iam::123456789:role/lambda-role"
        ;;
    list)
        aws_list_resources
        ;;
    cost)
        aws_cost_report
        ;;
    *)
        usage
        ;;
esac
