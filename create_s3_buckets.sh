#!/bin/bash

# Function to create S3 buckets for different departments

create_s3_buckets() {
    company="godwin-bucket"
    region="us-east-1"
    departments=("Marketing" "Sales" "HR" "Operations" "Media")

    for department in "${departments[@]}"; do
        bucket_name="${company}-${department,,}-data-bucket"  # ,,: make department lowercase

        # Check if the bucket already exists
        if aws s3api head-bucket --bucket "$bucket_name" --region "$region" 2>/dev/null; then
            echo "S3 bucket '$bucket_name' already exists."
        else
            aws s3api create-bucket \
                --bucket "$bucket_name" \
                --region "$region"

            if [ $? -eq 0 ]; then
                echo "S3 bucket '$bucket_name' created successfully."
            else
                echo "Failed to create S3 bucket '$bucket_name'."
            fi
        fi
    done
}

# Call the function
create_s3_buckets

