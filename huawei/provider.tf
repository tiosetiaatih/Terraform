terraform {
  backend "s3" {
    bucket      = "bucket-terraform-state"
    key         = "terraform.tfstate"
    region      = "ap-southeast-4"
    endpoint    = "https://obs.ap-southeast-4.myhuaweicloud.com"
    access_key  = "SAXBLVVQD6XIRS6UKG93"
    secret_key  = "1HKMRh9v85ssMib47xRUaHyaJPKYlA8T9w1Yqdlj"
    
    # bypass AWS-specific checks
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}