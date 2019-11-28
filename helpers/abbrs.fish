begin
    set -lx action $argv[1]
    set -lx context (tint: 778899 [zephish/(status --current-filename)])

    if not test $action = "install"
        and not test $action = "uninstall"
        echo $context Invalid argument (bold: (tint: red $action)) passed to abbrs. Expects either (bold: (tint: cyan install)) or (bold: (tint: cyan uninstall))
        exit 1
    end

    function abrv
        if test $action = "install"
            abbr -a $argv
        else
            abbr -e $argv[1]
        end
    end

    # Quick edit access for Zephish plugin
    abrv EZ code ~/.local/share/omf/pkg/zephish

    # General abbreviations
    abrv c clear
    abrv e exit
end