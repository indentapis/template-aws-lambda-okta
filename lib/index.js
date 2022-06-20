"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handle = void 0;
const integration_okta_1 = require("@indent/integration-okta");
const runtime_aws_lambda_1 = require("@indent/runtime-aws-lambda");
exports.handle = runtime_aws_lambda_1.getLambdaHandler({
    integrations: [new integration_okta_1.OktaGroupIntegration(), new integration_okta_1.OktaUserIntegration()],
});
//# sourceMappingURL=index.js.map