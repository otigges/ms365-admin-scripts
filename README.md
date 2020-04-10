# Microsoft 365 and Teams administration

This repository contains some PowerShell scripts for administration of Microsoft 365 AD and Teams:

1. Fetch users of a group recursively from sub groups
2. Assign a policy package to those users.

If you have any questions, suggestions or feature requests, please open an issue here: https://github.com/otigges/ms365-admin-scripts/issues

## Prerequisites

In order to adminstrate Azure AD groups and users their policies in Microsoft Teams you need to install these Powershell Modules:

`Install-Module AzureAdPreviews`
`Install-Module -Name MicrosoftTeams`

Hint: Maybe, you need to install C++ libraries first. Please download from: https://support.microsoft.com/de-de/help/2977003/the-latest-supported-visual-c-downloads

## Preparation

For each administration session you need to login in to both Azure AD and Microsoft Teams:

`Connect-AzureAD`
`Connect-MicrosoftTeams`

See https://docs.microsoft.com/en-us/powershell/module/azuread/connect-azuread?view=azureadps-2.0 for more information.
[TODO]: Find out how to use access tokens.

## Select all users from a parent group

Find the group:

`$group = Get-AzureADGroup | where displayname -eq "<group name>"`

Now the group is bound to variable `$group`.

Fetch all members recursively using the script `Fetch-GroupMembers.ps1`:

`$members = .\Fetch-GroupMembers.ps1 -group $group`

The members of this group are bound to variable `$members`. You can inspect them in PowerSehll by just typing:

`$members`

## Assign policy package to all members

You can display all available policy packages using:

`Get-CsPolicyPackage`

The "Name" field corresponds the policy package's "Identity".

Bind the desired policy package, e.g. "Education_PrimaryStudent", to the variable `$policyPackage`:

`$policyPackage = Get-CsPolicyPackage -Identity "Education_PrimaryStudent"`

Finally, you can assign this package to all selected members using the `Assign-PolicyPackage.ps1`script:

`.\Assign-PolicyPackage.ps1 $users $policyPackage`
