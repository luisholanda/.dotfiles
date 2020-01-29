# Defined in - @ line 1
function lt --wraps='ls --tree' --description 'alias lt=ls --tree'
  ls --tree $argv;
end
