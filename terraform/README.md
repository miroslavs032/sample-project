# Sample Project

This project objective is to provide teraform scripts to create IAM resources (users and groups) on the AWS cloud.

Groups and Users:
 - Ops
   - Santiago
   - Felix
   - Morgan
 - Developers
   -  Eugene
   - Milo
   - Abigail
   - Aidan

Roles:
 - ops_role
 - developers_role

Before running terraform, you must install the binary. 

`brew install terraform`

AWS CLI and credentials allows terraform to store and retrieve state from an S3 bucket.

```
$ aws configure
AWS Access Key ID [****************XSZQ]:
AWS Secret Access Key [****************YA9d]:
Default region name [eu-west-1]:
Default output format [json]:
```

By running `terraform init, plan and apply` you will initiate creation of IAM resources as defined in the `iam.tf` file.

Don't forget to run `terraform destory` when you finish testing, to avoid paying additional AWS fees.
