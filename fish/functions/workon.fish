function workon --description 'Goto the given project' --argument project
  if test -d ~/TerraMagna/repositories/$project
    cd ~/TerraMagna/repositories/$project
  else if test -d ~/Projects/$project
    cd ~/Projects/$project
  else
    echo "Project $project not found"
    return 1
  end

  if test -d ~/.pyenv/versions/$project
    pyenv activate $project
  else if set -q PYENV_ACTIVATE_SHELL
    pyenv deactivate
  end
end
