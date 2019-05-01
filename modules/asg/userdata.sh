#! /bin/bash
    
sudo yum update
sudo yum install aws-cli
cd /home/ec2-user/
aws s3 cp s3://aws-codedeploy-${region}/latest/install . --region ${region}
chmod +x ./install
sudo ./install auto
service codedeploy-agent status