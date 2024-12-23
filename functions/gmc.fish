function gmc --description "Move git commit to another branch"
    # Check if branch name argument is provided
    if test (count $argv) -lt 1
        echo "Usage: gmc <target_branch_name> [base_branch]"
        echo " "
        echo (tint: grey "Moves last git commit to the target branch, creating it if it doesn't exist")
        return 1
    end

    # Store current branch name and target branch
    set current_branch (git branch --show-current)
    set new_branch $argv[1]
    set base_branch main

    # If second argument is provided, use it as base branch
    if test (count $argv) -ge 2
        set base_branch $argv[2]
    end

    # Check if target branch exists
    if git show-ref --verify --quiet refs/heads/$new_branch
        if test (count $argv) -ge 2
            echo "Error: Branch '$new_branch' already exists and base branch was specified"
            return 1
        else
            git checkout $new_branch
        end
    else
        # Create new branch from base_branch
        if not git show-ref --verify --quiet refs/heads/$base_branch
            # If specified base branch doesn't exist, try master
            if test $base_branch = main -a (git show-ref --verify --quiet refs/heads/master)
                set base_branch master
            else
                echo "Error: Base branch '$base_branch' does not exist"
                return 1
            end
        end
        git checkout -b $new_branch $base_branch
    end

    # Get the last commit from original branch
    set commit (git rev-parse $current_branch~1..$current_branch)

    # Cherry pick the commit
    git cherry-pick $commit
end
