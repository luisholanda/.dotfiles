# Defined in - @ line 1
function unexport --wraps=unset --description 'alias unexport=unset'
  unset  $argv;
end
