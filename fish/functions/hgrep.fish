# Defined in - @ line 1
function hgrep --description 'alias hgrep=fc -El 0 | grep'
    fc -El 0 | grep $argv;
end
