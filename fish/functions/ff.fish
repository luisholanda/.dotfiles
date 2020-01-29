# Defined in - @ line 1
function ff --wraps='find . -type f -name' --description 'alias ff=find . -type f -name'
  find . -type f -name $argv;
end
