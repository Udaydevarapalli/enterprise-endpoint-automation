<#
.SYNOPSIS
Safely disables a scheduled task in enterprise-managed Windows environments.

.DESCRIPTION
This script checks for the existence and state of a scheduled task and disables it
only if necessary. Designed to be safe for repeated execution via SCCM or Intune
remediation cycles.

.NOTES
Sanitized example for public sharing.
#>

$TaskName = "ExampleTaskName"
$TaskPath = "\"

try {
    $task = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath -ErrorAction SilentlyContinue

    if ($null -ne $task) {
        if ($task.State -ne 'Disabled') {
            Disable-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath
            Write-Output "Scheduled task '$TaskName' disabled successfully."
        }
        else {
            Write-Output "Scheduled task '$TaskName' is already disabled."
        }
    }
    else {
        Write-Output "Scheduled task '$TaskName' not found."
    }
}
catch {
    Write-Error "Failed to evaluate or disable scheduled task: $_"
}
