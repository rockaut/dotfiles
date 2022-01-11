
$latest = (Invoke-WebRequest "https://api.github.com/repos/starship/starship/releases" | ConvertFrom-Json)[0].tag_name
New-Item -Type Directory -Force -Path $env:USERPROFILE\.local\bin
Invoke-WebRequest -Uri https://github.com/starship/starship/releases/download/$latest/starship-i686-pc-windows-msvc.zip -OutFile $env:TEMP\starship.zip
Expand-Archive -Force -Path $env:TEMP\starship.zip -DestinationPath $env:USERPROFILE\.local\bin\
Remove-Item -Path $env:TEMP\starship.zip

Copy-Item -Verbose -Path $env:USERPROFILE\code\personal\dotfiles\common\* -Destination $env:USERPROFILE\

New-Item -Type Directory -Force -Path $env:USERPROFILE\Documents\PowerShell
New-Item -Type Directory -Force -Path $env:USERPROFILE\Documents\WindowsPowerShell
Copy-Item -Verbose -Path $env:USERPROFILE\code\personal\dotfiles\win\Microsoft.PowerShell_profile.ps1 $env:USERPROFILE\Documents\PowerShell
Copy-Item -Verbose -Path $env:USERPROFILE\code\personal\dotfiles\win\Microsoft.PowerShell_profile.ps1 $env:USERPROFILE\Documents\WindowsPowerShell

Copy-Item -Verbose -Path $env:USERPROFILE\code\personal\dotfiles\win\terminal.settings.json $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
