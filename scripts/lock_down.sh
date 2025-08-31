# Secure the public bucket again
# Usage: ./lock_down.sh <public-bucket-name>

PUB=$1

echo "[+] Locking down bucket $PUB..."

# Remove public policy
aws s3api delete-bucket-policy --bucket "$PUB"

# Re-enable block public access
aws s3api put-public-access-block --bucket "$PUB" --public-access-block-configuration \
'{"BlockPublicAcls":true,"IgnorePublicAcls":true,"BlockPublicPolicy":true,"RestrictPublicBuckets":true}'

echo "[+] Bucket $PUB secured again."
