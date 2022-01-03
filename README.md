# My PERSONAL dotfiles

```bash
sudo apt update && sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    git

mkdir -p ~/code/personal

git clone git@github.com:rockaut/dotfiles.git ~/code/personal/dotfiles

~/code/personal/dotfiles/install.sh

~/code/personal/dotfiles/tools.sh

```

```pwsh
New-Item -Type Directory -Force -Path $env:USERPROFILE\documents\code\personal
git clone git@github.com:rockaut/dotfiles.git $env:USERPROFILE\documents\code\personal\dotfiles
```
