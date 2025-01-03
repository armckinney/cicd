def call() {
    sh """
        # configure CICD agent to assume the iac-deployer role in the associated account
        export \$(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
            \$(aws sts assume-role \
            --role-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/iac-deployer" \
            --role-session-name terraform \
            --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
            --output text))
    """
}

return this;
