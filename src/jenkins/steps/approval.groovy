def call() {
    buildUser = currentBuild.rawBuild.getCause(Cause.UserIdCause).getUserId()
    echo "Terraform Plan Approved by: ${buildUser}"
}

return this;
