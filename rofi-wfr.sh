#!/bin/sh

while true; do
    file_name=$(echo -n "" | rofi -dmenu -p "Enter file name")

    if [[ -z "$file_name" ]]; then
        notify-send "No file name entered. Aborting."
        exit 1
    fi

    if [[ -f $HOME/videos/$file_name.mp4 ]]; then
        continue
    else
        break
    fi
done

wf-recorder -c libx264rgb -f $HOME/videos/$file_name.mp4

notify-send "Video saved as $file_name.mp4"
