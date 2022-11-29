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

  env = {
    OKTA_DOMAIN       = var.okta_domain
    OKTA_TOKEN        = var.okta_token
    OKTA_SLACK_APP_ID = var.okta_slack_app_id
    OKTA_CLIENT_ID    = var.okta_client_id
    OKTA_PRIVATE_KEY  = var.okta_private_key
  }
  
  indent_webhook_secret = "idt-okta-secret"
  secrets_backend = "aws-secrets-manager"
  secrets_prefix  = "idt-okta-"
  env = {
    OKTA_DOMAIN           = "idt-okta-secret"
    OKTA_TOKEN            = "idt-okta-secret"
  }
}
```
