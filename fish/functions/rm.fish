# Defined in - @ line 1
function rm --wraps='rm -i' --description 'alias rm=rm -i'
 command rm -i $argv;
end
