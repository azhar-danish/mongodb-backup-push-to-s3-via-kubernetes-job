Mongodb-backup-push-to-s3-via-k8s-job

1. Create a bucket with name like "my-mongodb-backups-azhar"

2. Create an IAM user like "users3fullAccess" and add policy "AmazonS3FullAccess" and add Custom Inline Policy   
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::my-mongodb-backups-azhar/*"
            }
        ]
    }

3.  aws configure using AWS_ACCESS_ID and SECRET_ACCESS_KEY

4. docker build -t docker build -t azhardanish9/mongodb-backup:1.0 .

5. docker push azhardanish9/mongodb-backup:1.0

6.  Using CLI 

    kubectl create secret generic aws-credentials \
    --from-literal=AWS_ACCESS_KEY_ID='YOUR_ACCESS_KEY' \
    --from-literal=AWS_SECRET_ACCESS_KEY='YOUR_SECRET_KEY'

7. kubectl apply -f k8s/mongodb-backup-job.yaml

8. k get jobs

9. k logs job/mongodb-backup

    output => 
            ======================================
            MongoDB Backup Started
            ======================================

            Database : movies
            Backup   : movies-2026-10-02-19-00-00.archive.gz
            S3 Path  : s3://my-mongodb-backups/mongodb/movies/2026-10-02-19-00-00/movies-2026-10-02-19-00-00.archive.gz

            Creating MongoDB backup...

            Backup created successfully.

            Uploading backup to S3...

            upload: backup/movies-2026-10-02-19-00-00.archive.gz to s3://my-mongodb-backups/...

            ======================================
            Backup uploaded successfully
            ======================================

10. Go to aws > s3 > your_bucket => find the file# mongodb-backup-push-to-s3-via-kubernetes-job
