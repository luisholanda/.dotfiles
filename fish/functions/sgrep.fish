# Defined in - @ line 1
function sgrep --description 'alias sgrep=grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
    grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}  $argv;
end
