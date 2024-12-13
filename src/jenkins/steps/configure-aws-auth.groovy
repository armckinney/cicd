def call(String awsAccountID) {
    sh '''
        # unset any existing profiles
        unset AWS_PROFILE
        
        # configure CICD agent to assume the terraform-writer role in the associated account
        export $(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
            $(aws sts assume-role \
            --role-arn "arn:aws:iam::${awsAccountID}:role/terraform-writer" \
            --role-session-name databricks-terraform \
            --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
            --output text))
    '''
}

return this;
