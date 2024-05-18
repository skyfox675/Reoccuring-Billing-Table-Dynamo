locals {
  uuidv5_namespace = "changeme" # Use a any UUID formated string as a custom namespace
  bills = {
    "Trello Premium Annual" = {
      vendor             = "Atlassian"
      nameOnAccount      = "Someone"
      amount             = "10.50"
      sourceAccount      = "account a"
      destinationAccount = "account b"
      vaultUuid          = "changeme"
      secretUuid         = "changeme"
      reoccuringDate     = "17 May"
      billingStart       = null # if null, will be assigned a date 1 year in the past from date.now()
      billingEnd         = null # if null, will be assigned a date 5 years in the future from date.now()
    }
  }
}

resource "aws_dynamodb_table_item" "this" {
  for_each = local.bills

  table_name = aws_dynamodb_table.this.id
  hash_key   = aws_dynamodb_table.this.hash_key

  item = jsonencode({
    "billId" : { "S" : uuidv5(local.uuidv5_namespace, each.key) },
    "vendor" : { "S" : each.value.vendor },
    "nameOnAccount" : { "S" : each.value.nameOnAccount },
    "amount" : { "S" : each.value.amount },
    "sourceAccount" : { "S" : each.value.sourceAccount },
    "destinationAccount" : { "S" : each.value.destinationAccount },
    "vaultUuid" : { "S" : each.value.vaultUuid },
    "secretUuid" : { "S" : each.value.SecretUuid },
    "reoccuringDate" : { "S" : each.value.reoccuringDate },
    "billingStart" : { "S" : each.value.billingStart != null ? each.value.billingStart : formatdate("DD MMM YYYY", timeadd(timestamp(), "-8760h")) },
    "billingEnd" : { "S" : each.value.billingEnd != null ? each.value.billingEnd : formatdate("DD MMM YYYY", timeadd(timestamp(), "43800h")) },
  })
}
