# In the first run this should be commented as it does not exist yet
terraform {
 backend "s3" {
   bucket         = "meanz-iac"
   key            = "state/k8s/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   kms_key_id     = "alias/iac-key"
   dynamodb_table = "terraform-state"
 }
}