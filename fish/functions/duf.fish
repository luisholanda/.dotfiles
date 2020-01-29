# Defined in - @ line 1
function duf --wraps='du -sh *' --description 'alias duf=du -sh *'
  du -sh * $argv;
end
