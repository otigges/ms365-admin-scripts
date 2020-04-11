
# You need to install:
#Install-Module -Name MicrosoftTeams 

# Maybe, you need to install C++ libraries first. Please download from:
# https://support.microsoft.com/de-de/help/2977003/the-latest-supported-visual-c-downloads

# Now, connect to teams:
# Connect-MicrosoftTeams

# Run the script:
# .\Assign-PolicyPackage.ps1 $users $policyPackageName 


## PARAMS

param (
[Parameter(Mandatory=$true,HelpMessage="Array containing the group members")][Array]$groupMembers,
[Parameter(Mandatory=$true,HelpMessage="The name of the policy package to assign")][String]$policyPackageName
)

## EXECUTE

$groupMembers | foreach {
    $user = $_
    if ($user.objectType -eq "user") {
        Write-Host "Assigning policy package '$($policyPackageName)' to user $($user.displayName)."
        Grant-CsUserPolicyPackage -Identity $user.objectId -PackageName $policyPackageName
    } else {
        Write-Error "Given object is not a user: $($user)!"
    }
}
