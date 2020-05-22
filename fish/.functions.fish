function fish_prompt
  # gets the error status of the last command and 
  # updates the prompt symbol color with the indication
  if test "$status" -ne "0"
    set -gx ARROW "$ERROR"
  else
    set -gx ARROW "$SUCCESS"
  end

  print_date 
  pretty_path 
  get_branch
  print_prompt
end

function print_prompt
  echo -e (set_color $ARROW)"\n❯ "(set_color normal)
end

function print_date
  set TIME_ICON \uF017
  set DATE_STRING (date -u '+%H:%M:%S')
  set_color $DATE_COLOR
  echo -n "$TIME_ICON $DATE_STRING UTC"
end

function pretty_path
  # by default, Fish shell does not print ~ for $HOME
  set CWD (pwd | sed "s|^$HOME|~|g")
  set HOME_ICON \uF07C
  set_color $PATH_COLOR
  echo -n "$HOME_ICON $CWD" 
end

function print_host
  set HOST_STRING (echo $hostname | cut -f1 -d".")
  # add a space at the end
  echo -n "$HOST_STRING "
end

function get_branch
  set branch_indicator \uF126
  set local_changes_indicator \uF01B
  set remote_changes_indicator \uF01A
  
  set_color $GIT_COLOR
  # /dev/null prevents nonsensical errors when you are on directories not tracked by git.
  if test (git status --porcelain 2> /dev/null | wc -l) -eq 0
    set indicator ""
  else
    set indicator "$local_changes_indicator"
  end
  
  set branch_name (git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if test "$branch_name" != ""
    echo -n " $branch_indicator$indicator $branch_name"
  end
end

function ghb
  set URL (git remote get-url --push origin | sed 's/\.git$/\/tree\//g')(git rev-parse --abbrev-ref HEAD)
  echo "launching url $url..."
  if test (uname) = "Linux"
    xdg-open $URL
  else
    # This will definitely work on Darwin, somewhere else maybe?  xdg-open doesn't seem like the best default
    open $URL
  end
end

function glc
  git rev-parse HEAD > /dev/null 2>&1
  if test "$status" -ne "0"
    # not a git repo
    set URL (pwd)
  else
    set URL (git remote get-url --push origin | sed 's/\.git$/\/commit\//g')(git rev-parse HEAD)
  end
  echo "$argv$URL"
end

function fish_greeting
  set_theme_colors
  if test (uname) = "Darwin"
    neofetch --kitty ~/src/dotfiles/assets/apple.png --size 450px
  else if test "$SSH_TTY" = ""
    neofetch --kitty ~/src/dotfiles/assets/arch.png --size 450px
  else 
    neofetch 
  end
end

function cal
  if test "$argv" = ""
    /usr/bin/cal | lolcat 2> /dev/null
  else
    /usr/bin/cal $argv | lolcat 2> /dev/null
  end
end

function set_theme_colors

#   set FG_COLOR    bd8141
#   set BG_COLOR    1e140a
#   set BRIGHT_RED  cb4b16
#   set CYAN        268bd2
#   set YELLOW      b58900
#   set ORANGE      FF9933

  if test "$FISH_THEME" = "gruvbox"
    set -gx ERROR      CC241D
    set -gx SUCCESS    98971A
    set -gx USER_COLOR C46210
    set -gx HOST_COLOR bfc225
    set -gx DATE_COLOR FF9933
    set -gx PATH_COLOR 268bd2
    set -gx GIT_COLOR  b58900
  else if test "$FISH_THEME" = "jellybeans"
    set -gx ERROR      CB0000
    set -gx SUCCESS    58A82F
    set -gx USER_COLOR 3399FF
    set -gx HOST_COLOR 00CC00
    set -gx DATE_COLOR FF9933
    set -gx PATH_COLOR 6B6FFF
    set -gx GIT_COLOR  03A9F4
  else
    set -gx ERROR      red
    set -gx SUCCESS    green
    set -gx USER_COLOR blue
    set -gx HOST_COLOR green
    set -gx DATE_COLOR yellow
    set -gx PATH_COLOR blue
    set -gx GIT_COLOR  cyan
  end
end
