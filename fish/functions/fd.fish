# Defined in - @ line 1
function fd --description 'alias fd=find . -type d -name'
    find . -type d -name $argv;
end
