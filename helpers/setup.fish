# Setups up common stuff in for my environment

set -U fish_greeting ""

if type -q code
    set -U EDITOR "code -w"
end

fish helpers/abbrs.fish install

# Platform specific setup
switch (uname)
    case Darwin
        # Install brew if it's not already present
        if not type -q brew
            /usr/bin/ruby -e "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        end
        if not type -q exa
            brew install exa
        end
        if not type -q bat
            brew install bat
        end
    case "*"
        echo "This platform won't have everything. PRs welcome."
end
