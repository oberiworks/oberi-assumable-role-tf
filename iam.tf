data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.principal]
    }
    actions = ["sts:AssumeRole"]
    condition {
      test     = "Bool"
      values   = [local.enforce_mfa]
      variable = "aws:MultiFactorAuthPresent"
    }
    condition {
      test     = "StringEquals"
      values   = var.allowed_usernames
      variable = "aws:username"
    }
  }
}

resource "aws_iam_role" "assumable_role" {
  name = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
  max_session_duration = var.max_session_duration
}

resource "aws_iam_role_policy_attachment" "oberi_account_role_policy_attachments" {
  role  = aws_iam_role.assumable_role.name
  policy_arn = var.assumed_role_policy_arn
}
