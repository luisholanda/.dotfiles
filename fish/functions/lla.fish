# Defined in - @ line 1
function lla --wraps='ls -lha' --description 'alias lla=ls -lha'
  ls -lha $argv;
end
