# Disable autocomplete error beep
unsetopt beep

# Does not print '%' for EOL.
export PROMPT_EOL_MARK=''

# Use color with less
export LESS='-R --use-color -Dd+r$Du+b$'

# Default page is most
export PAGER="most"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# Useful aliases
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls -A -l --color=auto'

# Saving dotfiles with script
alias dotfiles='~/Scripts/dotfiles.sh'

# Shared ZSH history configuration
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Starting spaceship prompt
export ZSH_THEME"spaceship"
source /usr/lib/spaceship-prompt/spaceship.zsh
