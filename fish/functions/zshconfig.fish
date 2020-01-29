# Defined in - @ line 1
function zshconfig --wraps='vim ~/.zshrc' --description 'alias zshconfig=vim ~/.zshrc'
  vim ~/.zshrc $argv;
end
