function ls --description "Alias exa if it exists"
    if type -q exa
        exa $argv
    else
        command ls $argv
    end
end