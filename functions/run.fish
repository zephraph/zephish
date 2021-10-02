function run --description "Run commands for a given package type"
  if test -f yarn.lock
    yarn run $argv
  else if test -f pnpm-lock.yaml
    pnpm run $argv
  else if test -f package-lock.json
    npm run $argv
  end
end
