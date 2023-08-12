#!/bin/fish

set tmp_file (mktemp /tmp/screenshot_XXXXXX.jpg)
grim -t jpeg -q 100 $tmp_file

set file_name (echo -n "" | rofi -dmenu -p "Enter file name")

if test -z $file_name
    notify-send "No file name entered. Aborting."
    exit 1
end

if test -f $HOME/pictures/$file_name.jpg
    set choice (echo -e "replace\nkeep & ignore" | rofi -dmenu -p "File with the same name exists.")

    switch $choice
    case "replace"
        mv "$tmp_file" "$HOME/pictures/$file_name.jpg"
        notify-send "Screenshot replaced the existing picture."
    case "keep & ignore"
        rm $tmp_file
        notify-send "Screenshot discarded. Existing picture kept."
    case "*"
        notify-send "Invalid choice or no action taken. Aborting."
        rm $tmp_file
        exit 1
    end
else
    mv "$tmp_file" "$HOME/pictures/$file_name.jpg"
    notify-send "Screenshot saved as $file_name.jpg"
end
