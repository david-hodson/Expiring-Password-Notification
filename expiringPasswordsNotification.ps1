# Get the current date
$todayDate = (Get-Date)
# Get formatted version of $todayDate for logging clarity
$todayDateFormatted = $todayDate.ToString("MM-dd-yyyy")
# Path to log location
$logLocation = <# Log path #>
# Calculate the expiring date which is 10 days from the current date
$expiringDate = (Get-Date).AddDays(10)

# Create empty PS Custom Object
$logInformation = [PSCustomObject] @()

# Retrieve the expiring users from Active Directory
$expiringUsers = Get-ADUser -filter { <# Filter parameters #> } –Properties <# Properties #> | Select-Object -Property <# Properties #> 
@{
    Name       = "ExpiryDate";
    Expression = { [datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed") }
}

# Iterate through each expiring user
foreach ($user in $expiringUsers) {

    # Check if the user's password expiry date falls within the expiring period
    if ($user.ExpiryDate -gt $todayDate -and $user.ExpiryDate -lt $expiringDate ) {
        
        # Retrieve user details
        $upn = $user.UserPrincipalName
        # Convert $user.ExpiryDate to MM-dd-yyyy format
        $expiryDate = $user.ExpiryDate.ToString("MM-dd-yyyy")

        # Define email parameters
        $emailSender = "Foo <foo@domain.com>"
        $emailBcc = "bar@domain.com"
        $emailRecipient = $upn
        $subject = "NOTIFICATION: Password Expiration"
        $body = "<# Email body text #>"
        $smtpServerAddress = <# Smtp address #>

        # Send the email notification
        Send-MailMessage -To $emailRecipient -From $emailSender -Subject $subject -Body $body -SmtpServer $smtpServerAddress -Priority High -Bcc $emailBcc
        
        # Add value of $todayDate to DateSent property, $upn to User property, and $expiryDate to ExpiryDate property to PS Custom Object on each iteration
        $logInformation += New-Object PSObject -Property @{DateSent = "$todayDateFormatted"; User = "$upn"; ExpiryDate = "$expiryDate" }
        
        # Log users identified
        $logInformation | Export-Csv -Path $logLocation -Append
    }
}

