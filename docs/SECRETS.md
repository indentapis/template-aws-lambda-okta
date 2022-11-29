Secrets management
==================

The Okta integration supports using AWS Secrets Manager to store its secrets.
To enable it, set `secrets_backend` to `aws-secrets-manager`. The environment
variables should then be set to the *name* of the AWS Secret.

An AWS Secret is a key-value store, so you can store multiple secret values
in the one Secret. A simple setup might store all of the secrets in one, and
could look like the following:

```
resource "aws_secretsmanager_secret" "integration-okta-secret" {
   name = "idt-okta-secret"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id = aws_secretsmanager_secret.integration-okta-secret.id
  secret_string = <<EOF
   {
    "INDENT_WEBHOOK_SECRET": "xyz987",
    "OKTA_DOMAIN": "my-okta-domain.okta.com",
    "OKTA_TOKEN": "00abc123",
   }
EOF
}

module "idt-okta-webhook" {
  // source, name, artifacts: same as in main.tf
  
  indent_webhook_secret = aws_secretsmanager_secret.integration-okta-secret.name
  secrets_backend = "aws-secrets-manager"
  
  // secrets_prefix  = "idt-okta-"
  env = {
    OKTA_DOMAIN           = aws_secretsmanager_secret.integration-okta-secret.name
    OKTA_TOKEN            = aws_secretsmanager_secret.integration-okta-secret.name

    // OKTA_SLACK_APP_ID = aws_secretsmanager_secret.integration-okta-secret.name - set if Slack is installed and managed with Okta
    // OKTA_CLIENT_ID    = aws_secretsmanager_secret.integration-okta-secret.name - for app-based authentication
    // OKTA_PRIVATE_KEY  = aws_secretsmanager_secret.integration-okta-secret.name - for app-based authentication
  }
}
```
