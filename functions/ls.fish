function ls --description "Run eza if installed else fall back to ls"
    if type -q eza
        eza $argv
    else
        command ls $argv
    end
end
