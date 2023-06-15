# Expiring Passwords Notification Script

## Author

David Hodson

## Synopsis

The "expiring_passwords.ps1" script is a PowerShell script designed to identify users whose passwords are expiring within a specified period and send them email notifications. The script retrieves user information from Active Directory, checks the password expiration dates, and sends email notifications to the affected users.

## Prerequisites

- Windows operating system with PowerShell installed.
- Active Directory module for PowerShell.
- Access to the Active Directory domain to retrieve user information.
- SMTP server details for sending email notifications.

## Usage

1. Open a text editor or PowerShell script editor of your choice.
2. Copy and paste the provided script into the editor.
3. Update the script with the required configuration values:

   - **`$logLocation`**: Path to the log file where the script will store information about sent notifications. Replace `<# Log path #>` with the desired log file path.
   - **`<# Filter parameters #>`**: Specify the filter parameters to retrieve the desired set of users from Active Directory. Update this section based on your requirements.
   - **`<# Properties #>`**: Specify the properties to retrieve for the expiring users. Update this section based on your requirements.
   - **`<# Email body text #>`**: Customize the email body text according to the content you want to include in the email notifications.
   - **`<# Smtp address #>`**: Replace `<# Smtp address #>` with the address of your SMTP server.

4. Save the script with a `.ps1` extension, for example, `expiring_passwords.ps1`.

## Execution

To run the script, follow these steps:

1. Open a PowerShell terminal.
2. Navigate to the directory where you saved the script using the `cd` command.
3. Execute the script by entering the following command:

   ```powershell
   .\expiring_passwords.ps1
   ```

   Note: The script execution may require administrative privileges depending on your system configuration.

4. The script will start executing and perform the following actions:

   - Get the current date and format it for logging purposes.
   - Calculate the expiration date, which is 10 days from the current date.
   - Retrieve the list of expiring users from Active Directory based on the specified filter parameters.
   - Iterate through each expiring user.
   - Check if the user's password expiration date falls within the specified period.
   - If the password is expiring soon, send an email notification to the user using the specified SMTP server details.
   - Add the sent notification information (current date, user, and expiration date) to the log object.
   - Append the log object to the log file specified by `$logLocation`.

## Logging

The script logs each sent notification to a specified log file in CSV format. The log file contains the following columns:

- **DateSent**: The date when the notification was sent in the format `MM-dd-yyyy`.
- **User**: The user's User Principal Name (UPN) who received the notification.
- **ExpiryDate**: The password expiration date for the user in the format `MM-dd-yyyy`.

The log file is initially created empty and appends new entries with each script execution. You can review the log file to keep track of the notifications sent.

## Customization

You can customize the script according to your requirements:

- Modify the filter parameters in the `Get-ADUser` command to retrieve specific sets of users from Active Directory. Refer to the Active Directory module documentation for more information on filter parameters.
- Adjust the expiration period by modifying the `AddDays` value in the `$expiringDate` calculation. For example, changing

 it to `(Get-Date).AddDays(7)` will notify users whose passwords are expiring in 7 days.
- Customize the email body text to include relevant information for the users.
- Modify the log file path and format as per your preference.

## Notes

- The script relies on the Active Directory module for PowerShell to retrieve user information. Ensure that you have the module installed and available in your PowerShell session.
- Make sure to configure the SMTP server details correctly to enable email notifications.
- Test the script in a controlled environment before deploying it to a production environment.

## License

This script is released under the [Apache License 2.0](LICENSE). Use it at your own risk.
