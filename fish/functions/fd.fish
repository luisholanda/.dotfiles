# Defined in - @ line 1
function fd --wraps='find . -type d -name' --description 'alias fd=find . -type d -name'
  find . -type d -name $argv;
end
