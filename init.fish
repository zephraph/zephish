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
    case Linux
        if test -d /home/linuxbrew/.linuxbrew
            set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
            set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
            set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
            set -q PATH; or set PATH ''; set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH;
            set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
            set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH;
        end
end

if type -q starship
    starship init fish | source
end

eval (ssh-agent -c >/dev/null 2>&1)
