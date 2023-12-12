# This helper script either installs or uninstalls the abbreviations found in abbrs
begin
    set -lx action $argv[1]
    set -lx context (tint: 778899 [zephish/(status --current-filename)])

    if not test $action = install
        and not test $action = uninstall
        echo $context Invalid argument (bold: (tint: red $action)) passed to abbrs. Expects either (bold: (tint: cyan install)) or (bold: (tint: cyan uninstall))
        exit 1
    end

    echo "# Source from zephish/abbreviations" >~/.config/fish/conf.d/abbreviations.fish
    while read -la line
        if test "$line[1]" = "#"
            or test -z "$line"
            continue
        end
        if test $action = install
            echo "abbr -a $line" >>~/.config/fish/conf.d/abbreviations.fish
        else
            abbr -e $line[1]
        end
    end <abbreviations

end
