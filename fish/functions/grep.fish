# Defined in - @ line 1
function grep --wraps='grep --color' --description 'alias grep=grep --color'
 command grep --color $argv;
end
