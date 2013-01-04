# import modules
if((get-module -name PsGet) -eq $null){
    write-host "Installing PsGet"
    (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

if((get-module -name Find-string -eq $null){
    install-module Find-string
    new-alias -name grep -value find-string
}

#alias

# dot source functions

# scripts

# list available modules