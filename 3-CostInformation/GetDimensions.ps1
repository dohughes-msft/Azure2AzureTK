# Powershell to get cost management dimensions

#$scope = "/subscriptions/69f95403-8f1d-40b6-8ff0-beba8f41adea"
$scope = "/providers/Microsoft.Billing/billingAccounts/8611537" # Trey research

$uri = "https://management.azure.com$scope/providers/Microsoft.CostManagement/dimensions?api-version=2025-03-01"



# Get the access token for passing in the header
$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
   'Content-Type'='application/json'
   'Authorization'='Bearer ' + $token.AccessToken
}

$queryResult = Invoke-RestMethod -Uri $uri -Method Get -Headers $authHeader
