# dot source from within the powershell profile
# . .\Ps-Ext.ps1

function New-PSSecureRemoteSession
{
	param ($sshServerName, $Cred)
	$Session = New-PSSession $sshServerName -UseSSL -Credential $Cred -ConfigurationName C2Remote
	Enter-PSSession -Session $Session
}
 
function New-PSRemoteSession
{
	param ($shServerName, $Cred)
	$shSession = New-PSSession $shServerName -Credential $Cred -ConfigurationName C2Remote
	Enter-PSSession -Session $shSession
}

set-alias ssh New-PSSecureRemoteSession
set-alias sh New-PSRemoteSession


function Test-InPath($fileName){
	$found = $false
	Find-InPath $fileName | %{$found = $true}

	return $found
}

function Find-InPath($fileName){
	$env:PATH.Split(';') | ?{!([System.String]::IsNullOrEmpty($_))} | %{
		if(Test-Path $_){
			ls $_ | ?{ $_.Name -like $fileName }
		}
	}
}