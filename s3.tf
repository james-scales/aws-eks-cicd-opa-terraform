# resource "aws_s3_bucket" "tfstate-bucket" {
#   bucket        = "scales-tfstate-bucket"
#   force_destroy = false
#   tags = {
#     Name = "tfstate-bucket"
#   }
# lifecycle {
#   prevent_destroy = true
# }

# }

# resource "aws_s3_bucket_versioning" "tfstate-bucket-versioning" {
#   bucket = aws_s3_bucket.tfstate-bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
#   lifecycle {
#   prevent_destroy = true
# }
# }