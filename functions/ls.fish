function ls --description "Run exa if installed else fall back to ls"
    if type -q exa
        exa $argv
    else
        command ls $argv
    end
end