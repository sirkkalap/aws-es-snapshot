# aws-es-snapshot

Follow the instructions at [1].

Copy aws-snapshot.example.py to aws-snapshot.py and follow the instructions in that file.

NOTE: In addition to the instructions You will need to add an IAM User with permission to
iam:PassRole to pass the S3 permission Role [1] "IAM Role" to ES.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "StmtXXXXXXXXX",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::XXXXXXXX:role/es-index-backups"
            ]
        }
    ]
}
```

The fields `aws_access_key_id` and `aws_secret_access_key` are available from
`IAM -> Users -> <username> -> Security credentials`

[1] http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains-snapshots.html

