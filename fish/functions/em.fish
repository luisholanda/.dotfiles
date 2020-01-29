# Defined in - @ line 1
function em --wraps='emacsclient -c' --description 'alias em=emacsclient -c'
  emacsclient -c $argv;
end
