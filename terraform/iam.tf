# USERS PER GROUPS

locals {
  developers_list = ["Eugene", "Milo", "Abigail", "Aidan"]
  ops_list        = ["Santiago", "Felix", "Morgan"]
  force_destroy   = true
}

# CREATE USERS 
resource "aws_iam_user" "users_developers" {
  for_each = toset(local.developers_list)
  name     = each.value
}

resource "aws_iam_user" "users_ops" {
  for_each = toset(local.ops_list)
  name     = each.value
}

# CREATE DEDICATED GROUPS 
resource "aws_iam_group" "group_developers" {
  name = "Developers"
  path = "/users/"
}

resource "aws_iam_group" "group_ops" {
  name = "Ops"
  path = "/users/"
}

# ADD USERS TO GROUPS
resource "aws_iam_user_group_membership" "developers_membership" {
  for_each = toset(local.developers_list)

  user   = aws_iam_user.users_developers[each.key].name
  groups = [aws_iam_group.group_developers.name]
}

resource "aws_iam_user_group_membership" "ops_membership" {
  for_each = toset(local.ops_list)

  user   = aws_iam_user.users_ops[each.key].name
  groups = [aws_iam_group.group_ops.name]
}

## OPS ROLE WITH OPS USERS ADDED AS PRINCIPALS
data "aws_iam_policy_document" "ops_assume_role_policy" {

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::255229101253:user/Santiago",
        "arn:aws:iam::255229101253:user/Felix",
        "arn:aws:iam::255229101253:user/Morgan"
      ]
    }
  }
}

resource "aws_iam_role" "iam_ops_role" {
  name               = "ops_role"
  assume_role_policy = data.aws_iam_policy_document.ops_assume_role_policy.json
}

## DEVELOPERS ROLE WITH OPS USERS ADDED AS PRINCIPALS
data "aws_iam_policy_document" "developers_assume_role_policy" {

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::255229101253:user/Eugene",
        "arn:aws:iam::255229101253:user/Milo",
        "arn:aws:iam::255229101253:user/Abigail",
        "arn:aws:iam::255229101253:user/Aidan"
      ]
    }
  }
}

resource "aws_iam_role" "iam_developers_role" {
  name               = "developers_role"
  assume_role_policy = data.aws_iam_policy_document.developers_assume_role_policy.json
}

