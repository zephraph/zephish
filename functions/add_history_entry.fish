# See https://unix.stackexchange.com/questions/631733/how-to-write-a-command-to-history-in-fish-shell
function add_history_entry --description "Adds a command to the shell history"
    begin
        # brew install flock
        flock 1
        and echo -- '- cmd:' (
      string replace -- \n \\n (string join ' ' $argv) | string replace \\ \\\\
    )
        and date +'  when: %s'
    end >>$__fish_user_data_dir/fish_history
    and history merge
    atuin history start $argv >/dev/null
end
