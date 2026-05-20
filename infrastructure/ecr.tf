resource "aws_ecr_repository" "backend" {
  name                 = "skillpulse-backend"
  image_tag_mutability = "MUTABLE" # Allows CI to update tags

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true # Allows terraform destroy to work even if images exist
}

resource "aws_ecr_repository" "frontend" {
  name                 = "skillpulse-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}

resource "aws_secretsmanager_secret" "app_secrets" {
  name                    = "skillpulse/app-secrets"
  description             = "Secrets for the SkillPulse application"
  recovery_window_in_days = 0 # Allows immediate deletion for testing
}

# We'll initialize a dummy secret value
resource "aws_secretsmanager_secret_version" "initial_version" {
  secret_id     = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode({
    DB_PASSWORD = "change-me-later"
  })
}
