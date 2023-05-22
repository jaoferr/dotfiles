# launch windows explorer inside current directory
alias ex='explorer.exe .'

# deletes Zone.Identifier file created on copying files between windows and wsl
alias rmid='find . -name "*:Zone.Identifier" -type f -delete'

# fixes WSL clock drift
alias fixclock="sudo ntpdate time.windows.com"