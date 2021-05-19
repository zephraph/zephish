# Setups up common stuff in for my environment

set -U fish_greeting ""

if type -q code
    set -U EDITOR "code -w"
end

# Install a git hook to automatically update after pulling/merging
if not test -f .git/hooks/post-merge
    cp templates/post-merge .git/hooks/post-merge
    chmod +x .git/hooks/post-merge
end

fish helpers/abbrs.fish install

# Platform specific setup
switch (uname)
    case Darwin
        # Install brew if it's not already present
        if not type -q brew
            /usr/bin/ruby -e "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        end
        if not type -q hub
            brew install hub
        end
        if not type -q gh
            brew install github/gh/gh
        end
        if not type -q exa
            brew install exa
        end
        if not type -q bat
            brew install bat
        end
        if not type -q fd
            brew install fd
        end
        if not type -q starship
            brew install starship
        end
        if not type -q delta
            brew install git-delta
            git config --global core.pager delta
            git config --global delta.syntax-theme Nord
        end
        if not type -d ~/.asdf
            git clone https://github.com/asdf-vm/asdf.git ~/.asdf
            cd ~/.asdf
            git checkout "(git describe --abbrev=0 --tags)"
        end
    case Linux
        sudo apt-get update
        if not dpkg -s build-essential
            sudo apt-get install build-essential
        end
        if not type -q hub
            wget -O hub.tgz https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz
            tar zxvf hub.tgz
            rm hub.tgz
            sudo ./hub-linux-amd64-2.14.2/install
            rm -rf hub-linux-amd64-2.14.2
        end
        if not type -q starship
            curl -fsSL https://starship.rs/install.sh | bash
        end
        if not type -q cargo
            curl https://sh.rustup.rs -sSf | sh
        end
        if not type -q bat
            cargo install --locked bat
        end
        if not type -q exa
            cargo install --locked exa
        end
        if not type -q fd
            cargo install --locked fd-find
        end
        if not type -q delta
            cargo install --locked git-delta
            git config --global core.pager delta
            git config --global delta.syntax-theme Nord
        end
    case "*"
        echo "This platform won't have everything. PRs welcome."
end
