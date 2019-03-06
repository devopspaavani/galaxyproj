provider "aws" {
  region = "${var.aws_region}"
}

#########################################
# IAM Role
#########################################

resource "aws_iam_role" "namd_role" {
  name               = "namd-ec2-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

#########################################
# IAM Policy
#########################################
resource "aws_iam_policy" "namd_policy" {
  name        = "${var.policy_name}"
  path        = "/"
  description = "namd policy"
  policy      = "${file("namd_policy.json")}"
}

#########################################
# IAM Policy Attachment
#########################################
resource "aws_iam_policy_attachment" "namd-policy-attach" {
  name       = "namd-policy-attach"
  roles      = ["${aws_iam_role.namd_role.name}"]
  policy_arn = "${aws_iam_policy.namd_policy.arn}"
}

#########################################
# IAM Instance Profile
#########################################

resource "aws_iam_instance_profile" "namd_profile" {
  name  = "namd_ec2_profile"
  roles = ["${aws_iam_role.namd_role.name}"]
}
