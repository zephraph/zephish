# zephish initialization hook
#
# WARNING: Stuff in this file gets run everytime a new 
# shell is created. Limit it to the absolute minimum required.
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

set PATH ./node_modules/.bin ~/go/bin ~/.cargo/bin $PATH

if type -q starship
    starship init fish | source
end
