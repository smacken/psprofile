## MODULES ##

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}exit

Enable-GitColors

Pop-Location

Start-SshAgent -Quiet

# Todo: display available modules in $profile\modules dir

# Ensure psget

# ensure that psget is on the computer
if((get-module -list | where { $_.Name -like "psget"}) -eq $null){
	(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

if((get-module psget) -eq $null){
	import-module psget
}

write-host "Available Modules (PsGet - Install-Module [module])"
get-psgetmoduleinfo * | select { $_.Id + " - " + $_.Title}

## PROMPT ##

function prompt
{
	$promptText = "PS>";
	$wi = [System.Security.Principal.WindowsIdentity]::GetCurrent()
	$wp = new-object 'System.Security.Principal.WindowsPrincipal' $wi
	
	if ( $wp.IsInRole("Administrators") -eq 1 )
	{
		$color = "Red"
		$title = "**ADMIN** on " + (hostname);
	}
	else
	{
		$color = "Green"
		$title = hostname;
	}
	
	write-host $promptText -NoNewLine -ForegroundColor $color
	$host.UI.RawUI.WindowTitle = $title;
	return " "
}

## ALIAS ##
. .\Alias.ps1

set-alias grep select-string

## DRIVES ##

# development
# skydrive
# dropbox

## DEVELOPMENT ##

# vsvars
# psake build ext