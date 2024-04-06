if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

set -Ux NVIM_APPNAME nvchad
set -Ux KERL_BUILD_DOCS yes

/usr/bin/mise activate fish | source
