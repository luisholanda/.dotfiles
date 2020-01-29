# Defined in - @ line 1
function p --wraps='ps -f' --description 'alias p=ps -f'
  ps -f $argv;
end
