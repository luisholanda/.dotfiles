function workon --description 'Goto the given project' --argument project
  if test -d ~/TerraMagna/repositories/$project
    cd ~/TerraMagna/repositories/$project
  else if test -d ~/Projects/$project
    cd ~/Projects/$project
  else
    echo "Project $project not found"
    exit 1
  end

  pyenv activate $project
end
