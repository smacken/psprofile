# first test that the user is running powershell as administrator
# otherwise they wont be able to set up

#if not running as administrator
# "Please run as administrator"
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

if((get-executionpolicy) -eq "Restricted"){
	set-executionpolicy "RemoteSigned"
}

# create a profile if one doesnt exist
if((test-path $profile) -eq $false){
	new-item -path $profile -type "file" -force
}

#copy profile template 
if((test-path "C:\Users\$env:username\My Documents\WindowsPowerShell") -ne $true){
    mkdir "C:\Users\$env:username\My Documents\WindowsPowerShell"
}

write-host "Copying PS profile"
cp -path .\* -destination "C:\Users\$env:username\My Documents\WindowsPowerShell" -force
