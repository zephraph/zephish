function ls --description "Alias bat if it exists"
    if type -q bat
        bat $argv
    else
        command cat $argv
    end
end