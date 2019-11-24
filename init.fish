# zephish initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

set fish_greeting ""

set PATH ./node_modules/.bin $PATH

if type -q code
    set -x EDITOR "code -w"
end

if type -q starship
    starship init fish | source
end

# Quick edit access for Zephish plugin
abbr -a EZ code ~/.local/share/omf/pkg/zephish

# General abbreviations
abbr -a c clear
abbr -a e exit

