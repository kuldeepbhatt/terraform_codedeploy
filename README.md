# terraform_codedeploy
This repo holds the a beautiful orchestrator written in Terraform which will build a beautiful infrastructure with just single command. . (terraform apply)

Steps to set up :
1. Install Terraform (video tutorial : https://learn.hashicorp.com/terraform/getting-started/install.html)
2. Set up AWS CLI (Optional) - https://docs.aws.amazon.com/polly/latest/dg/setup-aws-cli.html
  
  **Why Optional** :
  * This project have 'main.tf' file in 'dev' folder which consist the provider as "aws" and region as "us-east-1" by default. As for orchestration on aws through Terraform program either you need to set up the AWS User (Admin console user) using "provider" block, where you will have to define your AWS Key and AWS Secret Key for that user, but that is not safe.
  * The better option is to set up AWS CLI and define your user's Key and Secret key inside your terminal itself using AWS CLI which is more secure option than defining them openly in main file. So that it will stay encapsulated.
  
3. Clone the repository
4. Open terminal to the clonned repository path
5. Open dev folder 
      ```
      cd tf_aws_codedeploy/dev
      ```
 
6. Initialize Terraform
      ```
      terraform init
      ```
      
7. Check the plan insights what are the resources to be orchestrated
      ```
      terraform plan
      ```
      
 8. Execute the plan
      ```
      terraform apply
      ```
  
This process may take afew minutes and once the process will be completed, your AWS CodeDeploy orchestration will be up and running and it will be ready for any application deployment.
  
Cheers!
