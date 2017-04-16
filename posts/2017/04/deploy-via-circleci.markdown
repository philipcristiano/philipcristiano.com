<!--
.. title: Deploying This With CircleCI
.. slug: deploy-with-circle-ci
.. date: 2017-04-16 14:49:11 UTC
.. tags: circleci, deployment
.. link:
.. description:
.. type: text
-->

Despite using automated deploys for most things I work on I had put off setting up such a mechanism for this site. Not sure what took so long.

With CircleCI I added a `circle.yml` file of:

```
dependencies:
  override:
    - pip install -r requirements.txt

test:
  override:
    - make build

deployment:
  deploy:
    branch: master
    commands:
      - make upload
```

And then an S3 user with the right permissions.


```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1492350849000",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::philipcristiano.com",
                "arn:aws:s3:::philipcristiano.com/*"
            ]
        }
    ]
}
```
