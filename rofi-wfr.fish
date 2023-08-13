#!/bin/fish

while true
    set file_name (echo -n "" | rofi -dmenu -p "Enter file name")

    if test -z $file_name
        notify-send "No file name entered. Aborting."
        exit 1
    end

    if test -f $HOME/videos/$file_name.mp4
        continue
    else
        break
    end
end

wf-recorder -c libx264rgb -f $HOME/videos/$file_name.mp4

notify-send "Video saves as $file_name.mp4"
