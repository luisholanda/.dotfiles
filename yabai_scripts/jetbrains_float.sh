if yabai -m --windows \
  | jq -er 'map(select(.id == env.YABAI_WINDOW_ID).pid)[0] as $pid | map(select(.pid == $pid)) | length == 1' > /dev/null
then
  yabai -m window "${YABAI_WINDOW_ID}" --toggle float
fi
