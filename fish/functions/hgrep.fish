# Defined in - @ line 1
function hgrep --wraps='fc -El 0 | grep' --description 'alias hgrep=fc -El 0 | grep'
  fc -El 0 | grep $argv;
end
