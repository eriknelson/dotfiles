#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for region in `aws ec2 describe-regions --output text | cut -f4`
do
echo -e "\nListing RDS in region:'$region'..."
aws rds describe-db-instances \
	--region $region | \
	yq '.DBInstances[].DBInstanceIdentifier'
done
