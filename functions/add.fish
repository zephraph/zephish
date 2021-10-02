function add --description "Add a dependency for a given package manager"
  set -l options (fish_opt -s D -l dev)
  argparse $options -- $argv

  if test -n "$_flag_dev"
    if test -f yarn.lock
      yarn add $argv
    else if test -f pnpm-lock.yaml
      pnpm add $argv
    else if test -f package-lock.json
      npm add $argv
    end
  else
    if test -f yarn.lock
      yarn add --save-dev $argv
    else if test -f pnpm-lock.yaml
      pnpm add --save-dev $argv
    else if test -f package-lock.json
      npm add --save-dev $argv
    end
  end
  
end
