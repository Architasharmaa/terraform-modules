resource "aws_iam_role" "rds_iam_role" {
  name = "rds_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "rds.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "rds_iam_policy_attachment" {
  name       = "rds_iam_policy_attachment"
  roles      = [aws_iam_role.rds_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"  # Example policy ARN for S3 read-only access
}