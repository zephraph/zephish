# Oxide
function nt --description "Command to run tests for omicron"
    argparse n/nocapture -- $argv
    or return
    if set -ql _flag_nocapture
        echo (tint: black "cargo nextest run --no-capture -E \"test($argv)\"")
        cargo nextest run --no-capture -p omicron-nexus -E "test($argv)"
    else
        echo (tint: black "cargo nextest run -E \"test($argv)\"")
        cargo nextest run -p omicron-nexus -E "test($argv)"
    end
end
