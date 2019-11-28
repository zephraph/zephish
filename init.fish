# zephish initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

set PATH ./node_modules/.bin $PATH

if type -q starship
    starship init fish | source
end