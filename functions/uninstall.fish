function uninstall --description "Uninstall a local dependency"
  if test -f yarn.lock
    yarn remove $argv
  else if test -f pnpm-lock.yaml
    pnpm remove $argv
  else if test -f package-lock.json
    npm uninstall $argv
  end
end
