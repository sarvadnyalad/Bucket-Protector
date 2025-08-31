# Create demo buckets in AWS S3
# Usage: ./create_buckets.sh <public-bucket-name> <private-bucket-name> <region>

PUB=$1
PRV=$2
REGION=$3

echo "[+] Creating public bucket: $PUB"
aws s3api create-bucket --bucket "$PUB" --region "$REGION" \
  --create-bucket-configuration LocationConstraint="$REGION"

echo "[+] Creating private bucket: $PRV"
aws s3api create-bucket --bucket "$PRV" --region "$REGION" \
  --create-bucket-configuration LocationConstraint="$REGION"

echo "[+] Uploading test files..."
aws s3 cp ../files/hello.txt s3://$PUB/
aws s3 cp ../files/secret.txt s3://$PRV/

echo "[+] Buckets created successfully."
