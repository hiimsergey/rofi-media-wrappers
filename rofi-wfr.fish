#!/bin/fish
# Wraps wf-recorder (Wayland screen recorder) around a usable Rofi prompt

while true
    set file_name (echo -n "" | rofi -dmenu -p "Enter file name")

    if test -z $file_name
        notify-send "No file name entered. Aborting."
        exit 1
    end

    if test -f $HOME/videos/$file_name.mp4
        set choice (echo -e "rename\nreplace\nkeep & ignore" | rofi -dmenu -p "File with the same name exists!")

        switch $choice
            case "rename"
                continue
            case "replace"
                rm "$HOME/videos/$file_name.mp4"
                notify-send "Recording replaced the old one."
                break
            case "keep & ignore"
                notify-send "Screenshot discarded. Existing picture kept."
                exit 0
            case "*"
                notify-send "Invalid choice or no action taken. Aborting."
                exit 1
        end
    else
        break
    end
end

wf-recorder -c libx264rgb -f $HOME/videos/$file_name.mp4

notify-send "Video saved as $file_name.mp4"
