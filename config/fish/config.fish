# Start X at login
status is-login && [ -z "$DISPLAY" -a $XDG_VTNR = 1 ] &&  exec startx -- -keeptty

# disale useless stus
function fish_greeting; end
function fish_mode_prompt; end

# seting up prompt
if not set -q __fish_git_prompt_show_informative_status
    set -g __fish_git_prompt_show_informative_status 1
end
if not set -q __fish_git_prompt_color_branch
    set -g __fish_git_prompt_color_branch brmagenta
end
if not set -q __fish_git_prompt_showupstream
    set -g __fish_git_prompt_showupstream "informative"
end
if not set -q __fish_git_prompt_showdirtystate
    set -g __fish_git_prompt_showdirtystate "yes"
end
if not set -q __fish_git_prompt_color_stagedstate
    set -g __fish_git_prompt_color_stagedstate yellow
end
if not set -q __fish_git_prompt_color_invalidstate
    set -g __fish_git_prompt_color_invalidstate red
end
if not set -q __fish_git_prompt_color_cleanstate
    set -g __fish_git_prompt_color_cleanstate brgreen
end

function fish_prompt
  set error $status
  set mode --bold red

  switch $fish_bind_mode
    case default;     set color --bold red
    case insert;      set color --bold white
    case replace-one; set color --bold white
    case visual;      set color --bold brmagenta
  end

  if [ $error -eq 0 ]
    printf '[%s%s%s] ' (set_color red)      (basename $PWD) (set_color normal)
    printf '[%s%s%s] ' (set_color $color)   $fish_bind_mode (set_color normal)
    echo -e "\n"
  else
    printf '[%s%s%s] ' (set_color red)      (basename $PWD) (set_color normal)
    printf '[%s%s%s] ' (set_color $color)   $fish_bind_mode (set_color normal)
    printf '[%s%s%s] ' (set_color red)      (echo $error)   (set_color normal)
    echo -e "\n"
  end
end

set PATH /bin
set PATH /sbin $PATH
set PATH /usr/local/sbin $PATH
set PATH /usr/local/bin $PATH
set PATH /usr/bin $PATH
set PATH /usr/bin/site_perl $PATH
set PATH /usr/bin/vendor_perl $PATH
set PATH /usr/bin/core_perl $PATH

set PATH $HOME/.cargo/bin/ $PATH
set PATH $HOME/.fzf/bin $PATH
set PATH $HOME/.config/scripts $PATH
set PATH $HOME/.local/share/ponyup/bin $PATH

bind -M insert \cr 'fzy_select_history (commandline -b)'
bind -M insert \cf 'fzy_select_directory'

function fzy_select_history
    if test (count $argv) = 0
        set fzy_flags
    else
        set fzy_flags -q "$argv"
    end
    history|fzy $fzy_flags|read -l foo
    commandline -f repaint
    commandline $foo
end

function fzy_select_directory -d 'cd to a directory using fzy'
    fd . -t d | fzy | read -l foo
    if [ $foo ]
        cd $foo
    end
    commandline -f repaint
end

function l
    ls -al $argv
end

function md
    mkdir -p $argv
end

function ytmp3
    youtube-dl --ignore-errors  --yes-playlist --extract-audio --audio-format mp3 --output "%(title)s.%(ext)s" $argv
end

function py
    python $argv
end

function dl
	youtube-dl --ignore-errors --yes-playlist --extract-audio --audio-format mp3 --output "%(uploader)s/%(title)s.%(ext)s" $argv
end

function toradd
  transmission-remote -a $argv
end

function tordel
  transmission-remote -l | awk ' $2 == "100%" && $4 "Done" {print $1}' | xargs -n 1 -I % transmission-remote -t % -r
end

function man --description 'Format and display manual pages'
	set -q man_blink; and set -l blink (set_color $man_blink); or set -l blink (set_color -o green)
    set -q man_bold; and set -l bold (set_color $man_bold); or set -l bold (set_color -o red)
    set -q man_standout; and set -l standout (set_color $man_standout); or set -l standout (set_color blue)
    set -q man_underline; and set -l underline (set_color $man_underline); or set -l underline (set_color -u red)

    set -l end (printf "\e[0m")

    set -lx LESS_TERMCAP_mb $blink
    set -lx LESS_TERMCAP_md $bold
    set -lx LESS_TERMCAP_me $end
    set -lx LESS_TERMCAP_so $standout
    set -lx LESS_TERMCAP_se $end
    set -lx LESS_TERMCAP_us $underline
    set -lx LESS_TERMCAP_ue $end
    set -lx LESS '-R -s'

    set -lx GROFF_NO_SGR yes # fedora

    set -lx MANPATH (string join : $MANPATH)
    if test -z "$MANPATH"
        type -q manpath
        and set MANPATH (command manpath)
    end

    # Check data dir for Fish 2.x compatibility
    set -l fish_data_dir
    if set -q __fish_data_dir
        set fish_data_dir $__fish_data_dir
    else
        set fish_data_dir $__fish_datadir
    end

    set -l fish_manpath (dirname $fish_data_dir)/fish/man
    if test -d "$fish_manpath" -a -n "$MANPATH"
        set MANPATH "$fish_manpath":$MANPATH
        command man $argv
        return
    end
    command man $argv
end
