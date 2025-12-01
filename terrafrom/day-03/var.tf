variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string      
}
variable "region" {
  description = "The AWS region to create resources in"
  type = string
  default = "ap-south-1" 
}