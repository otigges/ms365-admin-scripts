
# You need to install 'AzureAdPreview':
# Install-Module AzureAdPreview

# Maybe, you need to install C++ libraries first. Please download from:
# https://support.microsoft.com/de-de/help/2977003/the-latest-supported-visual-c-downloads

# Then connect to Azure AD:
# Connect-AzureAD

# Retrieve the group:
# $group = Get-AzureADGroup | where displayname -like "Some group name expression *" 

# Now you can call this script:
# .\Fetch-GroupMembers.ps1 -group $group

## PARAMS

param (
[Parameter(Mandatory=$false,HelpMessage="Die ObjectID der (Ober-)Gruppe.")][String]$groupObjectId,
[Parameter(Mandatory=$false,HelpMessage="Die (Ober-)Gruppe.")][Microsoft.Open.AzureAD.Model.DirectoryObject]$group
)

## FUNCTIONS

function collectMembersInHiararchy {
    param($groupId, $collection)

    Write-Debug "Traversing group $($groupId)"
    Write-Debug "Received collection $($collection.Keys)"

    $groupMember = Get-AzureADGroupMember -objectId $groupId
    foreach ($member in $groupMember)
    { 
        Write-Debug "Checking member $($member.displayName)"
        if (($member.ObjectType -eq "user") -And !($collection.ContainsKey($member.ObjectId))) {
            Write-Debug "Coll $($collection.Keys) does not contain $($member.ObjectId))"
            $collection.add($member.ObjectId, $member)
        }
        elseif ($member.ObjectType -eq "group") {
            collectMembersInHiararchy $member.objectId $collection
        }
    }
} 

function getAllMembers {
    param($groupObjectId)
    $collection = @{}
    collectMembersInHiararchy $groupObjectId $collection
    return $collection.values
} 

## EXECUTE

if ($group){
    return getAllMembers($group.ObjectId) | sort | unique
} else {
    return getAllMembers($groupObjectId) | sort | unique
}









