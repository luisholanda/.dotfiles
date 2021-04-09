#!/usr/bin/env bash
#!nix-shell -i bash -p curl jq common-updater-scripts dotnet-sdk_5
UPDATE_SCRIPTS=(
  pkgs/games/osu-lazer/update.sh
)

custom_pkgs=$PWD
nixpkgs_src="$(echo $NIX_PATH | grep -oE 'nixpkgs=[^:]+' | sed "s/nixpkgs=//")"
temp_src="/tmp/dotfiles-nix-pkgs-update"
tempnixpkgs="$temp_src/$(basename $nixpkgs_src)"

printf "Creating temporary nixpkgs source..."
mkdir -p $temp_src
doas rsync -lr $nixpkgs_src $temp_src
doas chown -R "$(whoami)" $temp_src
chmod -R +rw $tempnixpkgs
echo " Done"

for script in $UPDATE_SCRIPTS; do
  echo "Executing update script: $script"
  script_pkg="$(dirname $script)"
  script_file="$(basename $script)"
  out="$custom_pkgs/$script_pkg"
  cd "$tempnixpkgs/$script_pkg"
  ./$script_file
  mkdir -p "$out"
  cp -ru . "$out"
  chmod +rw "$out"
done

printf "Update complete, removing temporary nixpkgs... "

doas rm -r $temp_src

echo " Done"
