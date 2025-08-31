# Test IAM least-privilege permissions
# Usage: ./test_permissions.sh <private-bucket-name> <aws-profile>

PRV=$1
PROFILE=$2

echo "[+] Listing objects in $PRV with profile $PROFILE..."
aws s3 ls s3://$PRV --profile $PROFILE

echo "[+] Attempting to read secret.txt..."
aws s3 cp s3://$PRV/secret.txt - --profile $PROFILE

echo "[+] Attempting to upload a new file (should fail)..."
echo "unauthorized upload attempt" > tmp.txt
aws s3 cp tmp.txt s3://$PRV/ --profile $PROFILE || echo "[!] Upload blocked as expected."

rm tmp.txt
