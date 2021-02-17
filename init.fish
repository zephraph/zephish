# zephish initialization hook
#
# WARNING: Stuff in this file gets run everytime a new 
# shell is created. Limit it to the absolute minimum required.
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

set PATH ./node_modules/.bin ./lua_modules/bin ~/go/bin ~/.cargo/bin ~/.bin $PATH

switch (uname)
    case Darwin
        # Hack to ensure python builds will work
        # https://github.com/pyenv/pyenv/issues/1219#issuecomment-684140087
        set PYTHON_CONFIGURE_OPTS "--with-openssl=(brew --prefix openssl)"
        set CFLAGS "-I(brew --prefix zlib)/include -I(brew --prefix sqlite)/include -I(brew --prefix bzip2)/include"
        set LDFLAGS "-L(brew --prefix zlib)/lib -L(brew --prefix sqlite)/lib -L(brew --prefix bzip2)/lib"
end

if type -q starship
    starship init fish | source
end

eval (ssh-agent -c)
