$Env:PATH += $Env:PATH + ";$Env:USERPROFILE\.local\bin"

if ( ! (Test-Path alias:ll) ) { set-alias -name ll -value dir }
if ( ! (Test-Path alias:wget) ) { set-alias -name wget -value Invoke-WebRequest }

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if ( (Test-Path $Env:USERPROFILE\.local\bin\starship.exe) ) {
  Invoke-Expression (&starship init powershell)
}
