# ☁️ AWS S3 Security Lab – Bucket protector 🔒

This project demonstrates how to **identify and fix common AWS S3 security misconfigurations**.  
Using the AWS Free Tier, I intentionally exposed a bucket to the public, proved the exposure, then secured it again using **Block Public Access** and **IAM least-privilege policies**.  

---

## 📖 Table of Contents
1. [Project Overview](#-project-overview)
2. [What You’ll Learn](#-what-youll-learn)
3. [Architecture](#-architecture)
4. [Step-by-Step Demo](#-step-by-step-demo)
5. [Key Policies](#-key-policies)
6. [Validation & Testing](#-validation--testing)
7. [Lessons Learned](#-lessons-learned)
8. [Recruiter-Friendly Explanation](#-recruiter-friendly-explanation)

---

## 🌍 Project Overview
Amazon S3 is one of the most widely used AWS services, but **misconfigured permissions** can expose sensitive data to the public internet.  
This project simulates a **real-world S3 security incident** and walks through the **remediation process**.  

⚡ Key actions:
- Created two S3 buckets: one public-demo, one private.  
- Made a bucket publicly accessible via policy.  
- Verified anonymous access via URL.  
- Secured the bucket by restoring **Block Public Access**.  
- Configured **least-privilege IAM policies** for controlled read-only access.  
- Validated results using AWS CLI.  

---

## 🧑‍💻 What You’ll Learn
✅ Difference between public and private S3 buckets  
✅ How Block Public Access works  
✅ Writing secure bucket policies (JSON)  
✅ Implementing IAM least-privilege principles  
✅ Testing with AWS CLI and anonymous access  

---

## 🏗️ Architecture
```
+----------------------+       +----------------------+
|   Public Bucket      |       |   Private Bucket     |
| (intentionally open) |       | (least privilege)    |
+----------+-----------+       +-----------+----------+
           |                               |
    Anonymous User                 IAM User (read-only)
           |                               |
   ✅ Could read objects          ✅ Can list/read objects
   ❌ Blocked after fix           ❌ Cannot write objects
```

---

## 📝 Step-by-Step Demo

### 1. Setup
- Created two S3 buckets:  
  - `my-public-demo-bucket`  
  - `my-private-demo-bucket`  

### 2. Public Bucket Exposure
- Disabled **Block Public Access**.  
- Added public-read bucket policy.  
- Verified that anyone could fetch `hello.txt` via `https://.../hello.txt`.  

### 3. Securing the Public Bucket
- Re-enabled **Block Public Access**.  
- Removed insecure bucket policy.  
- Retested → anonymous access returned **AccessDenied**.  

### 4. Private Bucket with IAM
- Attached custom IAM policy:  
  - Allowed only `s3:ListBucket` and `s3:GetObject`.  
- Created a programmatic IAM user with this policy.  
- Verified access via AWS CLI:  
  - ✅ List & read worked  
  - ❌ Upload/write blocked  
  - ❌ Anonymous access blocked  

---

## 🔑 Key Policies

### 🚨 Insecure Public-Read Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-public-demo-bucket/*"
    }
  ]
}
```

### ✅ Secure Least-Privilege Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ListBucket",
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::my-private-demo-bucket"
    },
    {
      "Sid": "ReadObjects",
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-private-demo-bucket/*"
    }
  ]
}
```

---

## 🧪 Validation & Testing
- **Anonymous test:** Accessed object URL in incognito browser → AccessDenied after fix.  
- **IAM test:**  
  ```bash
  aws s3 ls s3://my-private-demo-bucket --profile s3reader
  aws s3 cp s3://my-private-demo-bucket/secret.txt - --profile s3reader
  ```
  - List/read ✅
  - Upload ❌  

---

## 🎯 Lessons Learned
- **Never disable Block Public Access** in production.  
- Use **IAM policies** for precise, least-privilege access.  
- Always test with both **authorized** and **unauthorized** users.  
- Misconfigurations are easy to reproduce → real-world risks are high.  

---

---

## 📷 Screenshots 
- Public access confirmed ✔️  
- AccessDenied after fix 🔒  
- CLI tests with least-privilege ✅  

---

✨ **Next Steps:** Expand this lab by adding encryption (SSE-KMS), versioning, and CloudTrail monitoring.  
