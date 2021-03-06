data "aws_iam_policy_document" "assume-role" {
  dynamic "statement" {
    for_each = compact([var.source_account_id])
    content {
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.source_account_id}:root"]
      }
      actions = ["sts:AssumeRole"]
    }
  }

  dynamic "statement" {
    for_each = compact([var.saml_idp_arn])
    content {
      principals {
        type        = "Federated"
        identifiers = ["${var.saml_idp_arn}"]
      }

      actions = ["sts:AssumeRoleWithSAML"]

      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = ["https://signin.aws.amazon.com/saml"]
      }
    }
  }
}

resource "aws_iam_role" "route53domains-poweruser" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy_attachment" "route53domains-fullaccess" {
  role       = aws_iam_role.route53domains-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53DomainsFullAccess"
}

resource "aws_iam_role_policy_attachment" "route53-readonly" {
  role       = aws_iam_role.route53domains-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess"
}
