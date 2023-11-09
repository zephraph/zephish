# Oxide
function nt --description "Command to run tests for omicron"
    echo (tint: black "cargo nextest run -E \"test($argv)\"")
    cargo nextest run -p omicron-nexus -E "test($argv)"
end
