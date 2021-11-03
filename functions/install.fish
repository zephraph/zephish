function install --description "Install dependencies for a given package"
  if test -f yarn.lock
    yarn install
  else if test -f pnpm-lock.yaml
    pnpm install
  else if test -f package-lock.json
    npm install
  end
end
