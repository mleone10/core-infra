# IAM user for Antigravity headless daemon
resource "aws_iam_user" "antigravity_daemon" {
  name = "antigravity-daemon"

  tags = {
    ManagedBy = "terraform"
  }
}

# Attach AWS managed ReadOnlyAccess policy
resource "aws_iam_user_policy_attachment" "antigravity_daemon_readonly" {
  user       = aws_iam_user.antigravity_daemon.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Access key pair for daemon authentication
resource "aws_iam_access_key" "antigravity_daemon" {
  user = aws_iam_user.antigravity_daemon.name
}

# Outputs for credentials
output "antigravity_daemon_access_key_id" {
  description = "Access key ID for antigravity-daemon IAM user"
  value       = aws_iam_access_key.antigravity_daemon.id
}

output "antigravity_daemon_secret_access_key" {
  description = "Secret access key for antigravity-daemon IAM user"
  value       = aws_iam_access_key.antigravity_daemon.secret
  sensitive   = true
}
