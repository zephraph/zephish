# source: https://github.com/kowalski7cc/fish-readenv
function readenv --description "Reads the environment variables from a file"
    for file in $argv
        if test -r $file
            for row in (read -z < $file)
                set -l kv (string split -m 1 \= $row)
                set -gx (string trim $kv[1]) (string trim -c " \"" $kv[2])
            end
        end
    end
end
