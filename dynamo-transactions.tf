resource "aws_dynamodb_table" "sequence_tranactions_query" {
  name         = "sequence-transactions-query"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "transactionId"

  deletion_protection_enabled = true

  attribute {
    name = "transactionId"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "sequence-transactions-query"
  }

}
