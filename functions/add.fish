function add --description "Add a dependency for a given package manager"
  set -l options (fish_opt -s D -l dev)
  argparse $options -- $argv

  if test -n "$_flag_dev"
    if test -f yarn.lock
      echo "yarn add --dev $argv"
      yarn add --dev $argv
    else if test -f pnpm-lock.yaml
      pnpm add --save-dev $argv
    else if test -f package-lock.json
      npm install --save-dev $argv
    end
  else
    if test -f yarn.lock
      yarn add $argv
    else if test -f pnpm-lock.yaml
      pnpm add $argv
    else if test -f package-lock.json
      npm install $argv
    end
  end
  
end
