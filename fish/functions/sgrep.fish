# Defined in - @ line 1
function sgrep --wraps='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} ' --description 'alias sgrep=grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
  grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}  $argv;
end
