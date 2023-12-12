function ai --description "Run a chatgpt query"
    echo "$argv" | chat-gpt | glow
end
