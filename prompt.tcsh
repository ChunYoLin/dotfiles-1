onintr -
if (! $?prompt) goto end

set git_branch_name = `sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1:/'`
set git_branch_name_color = "%{\e[01m%}$git_branch_name%{\e[00m%}"
if ("_$user" == "_root") then
    set prompt = "%n@%m[$git_branch_name_color%~]# "
else
    set prompt = "%n@%m[$git_branch_name_color%~]% "
endif

end:
    onintr