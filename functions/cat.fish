function cat --description "Run bat if installed else fall back to cat"
    if type -q bat
        bat $argv
    else
        command cat $argv
    end
end