# Defined in - @ line 1
function t --wraps='tail -f' --description 'alias t=tail -f'
  tail -f $argv;
end
