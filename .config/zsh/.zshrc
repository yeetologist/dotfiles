paleofetch
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Enable colors and change prompt:
setopt autocd		# Automatically cd into typed directory.

#stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

#Duplicate History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Color completion for some things.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Completers for my own scripts
zstyle ':completion:*:*:sstrans*:*' file-patterns '*.(lst|clst)'
zstyle ':completion:*:*:ssnorm*:*' file-patterns '*.tsv'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# NNN
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_ARCHIVE="\\.(gz|tar|xz|rar|zip|zst)$"
export NNN_COLORS="3162"
export NNN_TMPFILE='/tmp/.lastd'
export NNN_PREVIEWDIR="$XDG_CACHE_HOME/nnn/previews"
NNN_PLUG_INLINE='b:!realpath "$nnn">>/home/bam/.config/shell/shortcutrc*;c:!code "$nnn"*;n:!nvim -c VimwikiIndex;v:!mpv "$nnn"*;w:!setbg "$nnn"*'
export NNN_PLUG="$NNN_PLUG_INLINE;\
*:togglex;\
3:mp3conv;\
d:diffs;\
D:dups;\
e:fzplug;\
f:fixname;\
i:imgview;\
I:imgur;\
k:pskill;\
m:cmusq;\
M:mimelist;\
o:fzopen;\
O:organize;\
p:preview-tabbed;\
P:preview-tui;\
r:ringtone;\
s:suedit;\
S:splitjoin;\
x:xdgdefault;"
export NNN_BMS="a:$HOME/dl/Videos/Animes;\
b:$HOME/.local/bin;\
c:$HOME/.config;\
C:$HOME/.cache;\
d:$HOME/dl;\
D:$HOME/Documents;\
e:$HOME/dl/Videos/Essential;\
g:$HOME/dl/git-clone;\
j:$HOME/dl/jd;\
l:$HOME/.local;\
m:$HOME/dl/Music;\
M:/mnt;\
n:$HOME/dl/Novel;\
p:$HOME/dl/Programs;\
P:$HOME/dl/Pictures;\
s:$HOME/dl/Videos/Series;\
S:$HOME/.local/src;\
t:$HOME/dl/Torrent;\
v:$HOME/dl/Videos;\
w:$HOME/dl/Pictures/Wallpapers;\
y:$HOME/dl/Videos/Youtube;"

n(){
nnn -Hdexr "$@"
[ -f "$NNN_TMPFILE" ] && . "$NNN_TMPFILE" && rm -f "$NNN_TMPFILE" > /dev/null
}

# Use lf to switch directories and bind it to ctrl-o
bindkey -s '^o' 'n\n'
# bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^y' 'config-edit\n'
bindkey -s '^h' 'hdmi\n'
bindkey -s '^a' 'anal\n'
bindkey -s '^p' 'ping -c 2 google.com\n'
bindkey -s '^b' 'xrandr --output eDP1 --off\n'
bindkey '^[[P' delete-char
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load Plugins; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme 2> /dev/null

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
source ~/.config/zsh/.p10k.zsh
