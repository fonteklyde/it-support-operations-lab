<#
.SYNOPSIS
    Automated user provisioning script for corp.homelab.local
.DESCRIPTION
    Creates domain users with standardized attributes and places them in designated OUs.
#>

Import-Module ActiveDirectory

$Users = @(
    @{
        FirstName = "Alex"
        LastName  = "Mercer"
        SamName   = "amercer"
        Dept      = "Information_Technology"
        Title     = "IT Support Specialist"
    },
    @{
        FirstName = "Sarah"
        LastName  = "Connor"
        SamName   = "sconnor"
        Dept      = "Finance"
        Title     = "Financial Analyst"
    }
)

$DefaultPassword = ConvertTo-SecureString "Welcome2026!" -AsPlainText -Force

foreach ($User in $Users) {
    $TargetOU = "OU=$($User.Dept),OU=Departments,OU=CORP_Enterprise,DC=corp,DC=homelab,DC=local"
    $UserPrincipalName = "$($User.SamName)@corp.homelab.local"
    
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($User.SamName)'")) {
        New-ADUser `
            -Name "$($User.FirstName) $($User.LastName)" `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -SamAccountName $User.SamName `
            -UserPrincipalName $UserPrincipalName `
            -Path $TargetOU `
            -AccountPassword $DefaultPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $false `
            -Title $User.Title `
            -Department $User.Dept
        
        Write-Host "[SUCCESS] Created user: $($User.SamName) in$TargetOU" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] User $($User.SamName) already exists." -ForegroundColor Yellow
    }
}