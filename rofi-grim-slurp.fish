#!/bin/fish
# Wraps grim (Wayland screenshot utility) and slurp (geometry tool) around a usable rofi prompt

canberra-gtk-play -i screen-capture &

# Take a screenshot using grim command and save it with a temporary file name
set tmp_file (mktemp /tmp/grim_slurp_XXXXXX.png)
grim -t png -q 100 -g (slurp) $tmp_file

while true
    # Use Rofi prompt to ask for a file name
    set file_name (echo -n "" | rofi -dmenu -p "Enter file name:")
    
    # Check if a file name was entered
    if test -z $file_name
        notify-send "No file name entered. Aborting."
        exit 1
    end
    
    if test -f $HOME/pictures/$file_name.png
        set choice (echo -e "rename\nreplace\nkeep & ignore" | rofi -dmenu -p "File with the same name exists!")
    
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