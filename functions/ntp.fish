function ntp
    set -l test (rg -A1 "\#\[(nexus_test|tokio::test)\]" --no-heading -IN | rg 'async fn (\w+)' -o --no-heading --color never | awk '{print $3}' | fzf)
    run_with_history nt $test
end
