# Microsoft 365 and Teams administration

This repository contains some PowerShell scripts for administration of Microsoft 365 AD and Teams:

1. Fetch users of a group recursively from sub groups
2. Assign a policy package to those users

If you have any questions, suggestions, or feature requests, please open an issue here: https://github.com/otigges/ms365-admin-scripts/issues

Of course, also pull requests are welcome.

## Prerequisites

In order to administrate Azure AD groups, users, and their policies in Microsoft Teams you need to install these Powershell Modules:

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

Find the group(s):

`$groups = Get-AzureADGroup | where displayname -eq "<group name>"`

or 

`$groups = Get-AzureADGroup -Searchstring "<group name>`

Now the groups are bound to variable `$groups`.

Fetch all members recursively using the script `Fetch-GroupMembers.ps1`:

`$members = .\Fetch-GroupMembers.ps1 -groups $groups`

The members of these groups are bound to variable `$members`. You can inspect them in PowerShell by just typing:

`$members`

## Assign policy package to all members

You can display all available policy packages using:

`Get-CsPolicyPackage`

The "Name" field corresponds the policy package's "Identity".

Finally, you can assign the desired policy to all group members, e.g.:

`.\Assign-PolicyPackage.ps1 $members "Education_SecondaryStudent"`
