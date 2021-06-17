function asdf --description "Run bat if installed else fall back to cat"
	if test "$argv" = "reshim golang"
		for env in (go env | tr -d '"')
			export $env
		end
	end
	command asdf $argv
end
