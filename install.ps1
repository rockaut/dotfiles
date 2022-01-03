
$latest = (Invoke-WebRequest "https://api.github.com/repos/starship/starship/releases" | ConvertFrom-Json)[0].tag_name
New-Item -Type Directory -Force -Path C:\Users\fism\.local\bin
Invoke-WebRequest -Uri https://github.com/starship/starship/releases/download/$latest/starship-i686-pc-windows-msvc.zip -OutFile $env:TEMP\starship.zip
Expand-Archive -Force -Path $env:TEMP\starship.zip -DestinationPath $env:USERPROFILE\.local\bin\
Remove-Item -Path $env:TEMP\starship.zip

Copy-Item -Verbose -Path C:\Users\fism\code\personal\common\* -Destination C:\Users\fism\

Copy-Item -Verbose -Path C:\Users\fism\code\personal\win\Microsoft.PowerShell_profile.ps1 $PROFILE
Copy-Item -Verbose -Path C:\Users\fism\code\personal\win\terminal.settings.json C:\Users\fism\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
