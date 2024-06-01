/*
terraform {
  backend "s3" {
    bucket         = "NAME_OF_BUCKET"
    key            = ".TFSTATE_FILE"
    region         = "REGION_OF_BUCKET"
    dynamodb_table = "NAME_OF_DYNAMODB_TABLE"
  }
}
*/