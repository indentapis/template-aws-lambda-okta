terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Okta Integration

# Details: https://github.com/indentapis/integrations/tree/24c64773d6dffb0e11215986c2a4f7a7ce5edaf6/packages/stable/indent-integration-okta
# Last Change: https://github.com/indentapis/integrations/commit/24c64773d6dffb0e11215986c2a4f7a7ce5edaf6

module "idt-okta-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-okta-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/okta-24c64773d6dffb0e11215986c2a4f7a7ce5edaf6-function.zip"
    deps_key     = "webhooks/aws/lambda/okta-24c64773d6dffb0e11215986c2a4f7a7ce5edaf6-deps.zip"
  }
  env = {
    OKTA_DOMAIN       = var.okta_domain
    OKTA_TOKEN        = var.okta_token
    OKTA_SLACK_APP_ID = var.okta_slack_app_id
    OKTA_CLIENT_ID    = var.okta_client_id
    OKTA_PRIVATE_KEY  = var.okta_private_key
  }
}

