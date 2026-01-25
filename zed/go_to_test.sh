
zed=$(command -v zed || command -v zeditor)

file="$ZED_RELATIVE_FILE"

if [ -z "$zed" ]; then
  echo "Zed CLI not found"
  exit 1
fi

if [[ "$file" == lib/* ]]; then
  base="${file#lib/}"
  target="test/${base%.*}_test.exs"
elif [[ "$file" == test/* ]]; then
  base="${file#test/}"
  target="lib/${base%_test.exs}.ex"
else
  echo "File must be in lib/ or test/"
  exit 1
fi

if [[ -f "$target" ]]; then
  $zed "$target"
else
  echo "Target $target not found."
  exit 1
fi
