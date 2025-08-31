# Intentionally expose the public bucket
# Usage: ./public_expose.sh <public-bucket-name>

PUB=$1

echo "[!] WARNING: Making bucket $PUB publicly readable..."

# Turn off block public access
aws s3api put-public-access-block --bucket "$PUB" --public-access-block-configuration \
'{"BlockPublicAcls":false,"IgnorePublicAcls":false,"BlockPublicPolicy":false,"RestrictPublicBuckets":false}'

# Apply public-read bucket policy
aws s3api put-bucket-policy --bucket "$PUB" --policy file://../policies/insecure-public-policy.json

echo "[+] Bucket $PUB is now public."
