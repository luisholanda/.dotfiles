# Defined in - @ line 1
function emacs --description 'alias emacs emacsclient -a "" -c'
    emacsclient -a "" -c $argv;
end
