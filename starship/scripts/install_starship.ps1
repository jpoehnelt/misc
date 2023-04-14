if (![bool](Get-Command -ErrorAction Ignore -Type Application starship))
{
    Write-Verbose -vb "Dependency [starship] missing, downloading"
    winget install --id Starship.Starship
}

if (-not(Test-Path "$HOME\repos\misc"))
{
    git clone https://github.com/Zekihan/misc.git "$HOME\repos\misc"
}
Set-Location "$HOME\repos\misc"
git pull --rebase --autostash --recurse-submodules
if (Test-Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1")
{
    Remove-Item "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
}
New-Item -ItemType SymbolicLink -Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$HOME\repos\misc\starship\.config\Microsoft.PowerShell_profile.ps1"
if (Test-Path "$HOME\.config\starship.toml")
{
    Remove-Item "$HOME\.config\starship.toml"
}
New-Item -ItemType SymbolicLink -Path "$HOME\.config\starship.toml" -Target "$HOME\repos\misc\starship\.config\starship.toml"
Set-Location -
