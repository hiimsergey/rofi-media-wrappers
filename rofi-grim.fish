#!/bin/fish
# Wraps grim (Wayland screenshot utility) around a usable rofi prompt

canberra-gtk-play -i screen-capture &

set tmp_file (mktemp /tmp/grim_XXXXXX.png)
grim -t png -q 100 $tmp_file

while true
    set file_name (echo -n "" | rofi -dmenu -p "Enter file name")
    
    if test -z $file_name
        notify-send "No file name entered. Aborting."
        exit 1
    end
    
    if test -f $HOME/pictures/$file_name.png
        set choice (echo -e "rename\nreplace\nkeep & ignore" | rofi -dmenu -p "File with same name exists!")
    
        switch $choice
            case "rename"
                continue
            case "replace"
                mv "$tmp_file" "$HOME/pictures/$file_name.png"
                notify-send "Screenshot replaced the existing picture."
                break
            case "keep & ignore"
                rm $tmp_file
                notify-send "Screenshot discarded. Existing picture kept."
                break
            case "*"
                notify-send "Invalid choice or no action taken. Aborting."
                rm $tmp_file
                exit 1
        end
    else
        mv "$tmp_file" "$HOME/pictures/$file_name.png"
        notify-send "Screenshot saved as $file_name.png"
        break
    end
end
