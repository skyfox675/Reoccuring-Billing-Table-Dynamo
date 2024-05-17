resource "aws_dynamodb_table" "this" {
  name         = "reoccuring-bill-pay"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "billId"

  deletion_protection_enabled = true

  attribute {
    name = "billId"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "reoccuring-bill-pay"
  }
}
