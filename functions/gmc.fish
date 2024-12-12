function gmc --description "Move git commit to another branch"
    # Check if branch name argument is provided
    if test (count $argv) -lt 1
        echo "Usage: gmc <branch_name> [number_of_commits]"
        echo " "
        echo (tint: grey "Moves git commits from one branch to another")
        return 1
    end

    # Store current branch name
    set current_branch (git branch --show-current)
    set target_branch $argv[1]
    set num_commits 1

    # If second argument is provided, use it as number of commits
    if test (count $argv) -ge 2
        set num_commits $argv[2]
    end

    # Check if target branch exists, if not create it from main/master
    if not git show-ref --verify --quiet refs/heads/$target_branch
        # Determine if main or master is used
        if git show-ref --verify --quiet refs/heads/main
            git checkout -b $target_branch main
        else
            git checkout -b $target_branch master
        end
    else
        # Switch to target branch if it exists
        git checkout $target_branch
    end

    # Get the last N commits from original branch
    set commits (git rev-parse $current_branch~$num_commits..$current_branch)

    # Cherry pick the commits in reverse order (oldest first)
    for commit in $commits[-1..1]
        git cherry-pick $commit
    end
end
