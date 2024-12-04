# zephish initialization hook
#
# WARNING: Stuff in this file gets run everytime a new 
# shell is created. Limit it to the absolute minimum required.
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

fish_add_path ./node_modules/.bin ./lua_modules/bin ~/go/bin ~/.cargo/bin ~/.bin /usr/local/Cellar/apache-spark/1.5.2/bin

# Fix for GPG TTY error
set -gx GPG_TTY (tty)
set -gx EDITOR (which cursor)

switch (uname)
    case Darwin
        # Hack to ensure python builds will work
        # https://github.com/pyenv/pyenv/issues/1219#issuecomment-684140087
        set PYTHON_CONFIGURE_OPTS "--with-openssl=(brew --prefix openssl)"
        set CFLAGS "-I(brew --prefix zlib)/include -I(brew --prefix sqlite)/include -I(brew --prefix bzip2)/include"
        set LDFLAGS "-L(brew --prefix zlib)/lib -L(brew --prefix sqlite)/lib -L(brew --prefix bzip2)/lib"
        fish_add_path ~/Code/deno.run/.run ~/Scripts ~/Applications /opt/local/bin
    case Linux
        set PKG_CONFIG_PATH "/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/local/lib/pkgconfig:/home/linuxbrew/.linuxbrew/lib/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig"
        if test -d ~/usr/local/Applications/android-studio/bin
            fish_add_path ~/Applications/android-studio/bin
        end
        if test -d /home/linuxbrew/.linuxbrew
            set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
            set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
            set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
            set -q PATH; or set PATH ''
            set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
            set -q MANPATH; or set MANPATH ''
            set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
            set -q INFOPATH; or set INFOPATH ''
            set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH
        end
        export RUSTDOCFLAGS="-Clink-args=-Wl,-R(pg_config --libdir)"
end

if type -q starship
    starship init fish | source
end

eval (ssh-agent -c >/dev/null 2>&1)

set -gx MISE_SHELL fish
set -gx __MISE_ORIG_PATH $PATH

function mise
    if test (count $argv) -eq 0
        command /Users/just-be/.local/bin/mise
        return
    end

    set command $argv[1]
    set -e argv[1]

    if contains -- --help $argv
        command /Users/just-be/.local/bin/mise "$command" $argv
        return $status
    end

    switch "$command"
        case deactivate shell sh
            # if help is requested, don't eval
            if contains -- -h $argv
                command /Users/just-be/.local/bin/mise "$command" $argv
            else if contains -- --help $argv
                command /Users/just-be/.local/bin/mise "$command" $argv
            else
                source (command /Users/just-be/.local/bin/mise "$command" $argv |psub)
            end
        case '*'
            command /Users/just-be/.local/bin/mise "$command" $argv
    end
end

function __mise_env_eval --on-event fish_prompt --description 'Update mise environment when changing directories'
    /Users/just-be/.local/bin/mise hook-env -s fish | source

    if test "$mise_fish_mode" != disable_arrow
        function __mise_cd_hook --on-variable PWD --description 'Update mise environment when changing directories'
            if test "$mise_fish_mode" = eval_after_arrow
                set -g __mise_env_again 0
            else
                /Users/just-be/.local/bin/mise hook-env -s fish | source
            end
        end
    end
end

function __mise_env_eval_2 --on-event fish_preexec --description 'Update mise environment when changing directories'
    if set -q __mise_env_again
        set -e __mise_env_again
        /Users/just-be/.local/bin/mise hook-env -s fish | source
        echo
    end

    functions --erase __mise_cd_hook
end
if functions -q fish_command_not_found; and not functions -q __mise_fish_command_not_found
    functions -e __mise_fish_command_not_found
    functions -c fish_command_not_found __mise_fish_command_not_found
end

function fish_command_not_found
    if /Users/just-be/.local/bin/mise hook-not-found -s fish -- $argv[1]
        /Users/just-be/.local/bin/mise hook-env -s fish | source
    else if functions -q __mise_fish_command_not_found
        __mise_fish_command_not_found $argv
    else
        __fish_default_command_not_found_handler $argv
    end
end
