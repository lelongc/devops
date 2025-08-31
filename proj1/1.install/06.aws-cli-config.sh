https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

# aws cli install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# configure aws cli
aws configure
# aws cli version
aws --version
# aws cli help
aws help
# configure aws cli
aws configure
aws configure --profile dev
aws configure --profile prod
# terraform deploy
terraform init
terraform plan
terraform apply