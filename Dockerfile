# FROM rundeck/rundeck:3.2.9
# syntax=docker/dockerfile:1.3-labs

FROM centos:7

# RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN yum -y install net-tools vim jq lsof

RUN yum -y install http://dev.mysql.com/get/mysql80-community-release-el7-7.noarch.rpm

RUN curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | bash -s rundeck && yum install -y rundeck-3.2.9.20200708-1.noarch

RUN yum -y install java-1.8.0-openjdk-devel


# aws s3 log storage plugin
RUN curl -OL https://github.com/rundeck-plugins/rundeck-s3-log-plugin/releases/download/v1.0.13/rundeck-s3-log-plugin-1.0.13.jar && mv rundeck-s3-log-plugin-1.0.13.jar /var/lib/rundeck/libext

ENTRYPOINT bash















# cat <<RUNDECK > /etc/rundeck/rundeck-config.properties
# loglevel.default=INFO
# rdeck.base=/var/lib/rundeck

# rss.enabled=false
# grails.serverURL=http://localhost:4440
# rundeck.projectsStorageType=db
# dataSource.driverClassName = org.mariadb.jdbc.Driver
# dataSource.dbCreate = update
# dataSource.url = jdbc:mysql://db/rundeck?autoReconnect=true
# dataSource.username = rundeck
# dataSource.password = rundeck

# rundeck.log4j.config.file = /etc/rundeck/log4j.properties

# rundeck.feature.repository.enabled=true

# # Enable DB for Key Storage
# rundeck.storage.provider.1.type=db
# rundeck.storage.provider.1.path=keys

# # AWS S3 Log Storage Plugin
# rundeck.execution.logs.fileStoragePlugin=org.rundeck.amazon-s3
# RUNDECK

# # ###
# # # /etc/rundeck/framework.properties
# # ###

# cat <<'FRAMEWORK' >> /etc/rundeck/framework.properties
# # AWS S3 Log Plugin
# # Authentication
# framework.plugin.ExecutionFileStorage.org.rundeck.amazon-s3.AWSAccessKeyId=AKIAUICRQGPYED323T6P
# framework.plugin.ExecutionFileStorage.org.rundeck.amazon-s3.AWSSecretKey=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

# ##name of the bucket
# framework.plugin.ExecutionFileStorage.org.rundeck.amazon-s3.bucket=nysdin-rundeck-scm-test-log
# ##path to store the logs
# framework.plugin.ExecutionFileStorage.org.rundeck.amazon-s3.path=/stg/logs/${job.project}/${job.execid}/${job.execid}.log
# FRAMEWORK


# SELECT
# COUNT(dmm.id) / COUNT(DISTINCT students.id) AS average_dm,
# date_format(dmm.created_at, '%Y/%m') AS date
# FROM syukatsu_kaigi_production_direct_mail_messages AS dmm
# INNER JOIN syukatsu_kaigi_production_students AS students ON students.id = dmm.student_id
# INNER JOIN syukatsu_kaigi_production_student_schools AS student_schools ON student_schools.student_id = students.id
# WHERE student_schools.scheduled_graduation_year IN (2022, 2023, 2024)
# AND dmm.created_at >= current_timestamp - interval '1' year
# GROUP BY date_format(dmm.created_at, '%Y/%m')
# ORDER BY date DESC


# {
# "Version": "2012-10-17",
# "Id": "key-consolepolicy-3",
# "Statement": [
# {
# "Sid": "Enable IAM User Permissions",
# "Effect": "Allow",
# "Principal": {
# "AWS": "arn:aws:iam::106771229015:root"
# },
# "Action": "kms:*",
# "Resource": "*"
# },
# {
# "Sid": "Allow access for Key Administrators",
# "Effect": "Allow",
# "Principal": {
# "AWS": [
# "arn:aws:iam::106771229015:user/yuki.onodera@theport.jp",
# "arn:aws:iam::106771229015:user/takuma.saito@theport.jp",
# "arn:aws:iam::106771229015:role/KMSForAdministrator"
# ]
# },
# "Action": [
# "kms:Create*",
# "kms:Describe*",
# "kms:Enable*",
# "kms:List*",
# "kms:Put*",
# "kms:Update*",
# "kms:Revoke*",
# "kms:Disable*",
# "kms:Get*",
# "kms:Delete*",
# "kms:TagResource",
# "kms:UntagResource",
# "kms:ScheduleKeyDeletion",
# "kms:CancelKeyDeletion"
# ],
# "Resource": "*"
# },
# {
# "Sid": "Allow use of the key",
# "Effect": "Allow",
# "Principal": {
# "AWS": [
# "arn:aws:iam::106771229015:user/yuki.onodera@theport.jp",
# "arn:aws:iam::106771229015:user/takuma.saito@theport.jp",
# "arn:aws:iam::106771229015:role/KMSForAdministrator"
# ]
# },
# "Action": [
# "kms:Encrypt",
# "kms:Decrypt",
# "kms:ReEncrypt*",
# "kms:GenerateDataKey*",
# "kms:DescribeKey"
# ],
# "Resource": "*"
# },
# {
# "Sid": "Allow attachment of persistent resources",
# "Effect": "Allow",
# "Principal": {
# "AWS": [
# "arn:aws:iam::106771229015:user/yuki.onodera@theport.jp",
# "arn:aws:iam::106771229015:user/takuma.saito@theport.jp",
# "arn:aws:iam::106771229015:role/KMSForAdministrator"
# ]
# },
# "Action": [
# "kms:CreateGrant",
# "kms:ListGrants",
# "kms:RevokeGrant"
# ],
# "Resource": "*",
# "Condition": {
# "Bool": {
# "kms:GrantIsForAWSResource": "true"
# }
# }
# },
# {
# "Sid": "Allow use of the key",
# "Effect": "Allow",
# "Principal": {
# "Service": [
# "codestar-notifications.amazonaws.com",
# "ses.amazonaws.com",
# "cloudwatch.amazonaws.com",
# "codecommit.amazonaws.com",
# "s3.amazonaws.com",
# "events.amazonaws.com"
# ]
# },
# "Action": [
# "kms:GenerateDataKey*",
# "kms:Decrypt"
# ],
# "Resource": "*"
# },
# {
# "Sid": "Allow access through SNS for all principals in the account that are authorized to use SNS",
# "Effect": "Allow",
# "Principal": {
# "AWS": "*"
# },
# "Action": [
# "kms:Decrypt",
# "kms:GenerateDataKey*",
# "kms:CreateGrant",
# "kms:ListGrants",
# "kms:DescribeKey"
# ],
# "Resource": "*",
# "Condition": {
# "StringEquals": {
# "kms:ViaService": "sns.ap-northeast-1.amazonaws.com",
# "kms:CallerAccount": "106771229015"
# }
# }
# }
# ]
# }
