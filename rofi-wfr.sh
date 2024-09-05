#!/bin/sh
# Wraps wf-recorder (Wayland screen recorder) around a usable Rofi prompt

while true; do
    file_name=$(echo -n "" | rofi -dmenu -p "Enter file name")

    if [[ -z "$file_name" ]]; then
        notify-send "No file name entered. Aborting."
        exit 1
    fi

    if [[ -f $HOME/videos/$file_name.mp4 ]]; then
        choice=$(echo -e "rename\nreplace\nkeep & ignore" | rofi -dmenu -p "File with the same name exists!")

        case "$choice" in
            "rename")
                continue
                ;;
            "replace")
                rm "$HOME/videos/$file_name.mp4"
                notify-send "Recording replaced the old one."
                break
                ;;
            "keep & ignore")
                notify-send "Screenshot discarded. Existing picture kept."
                exit 0
                ;;
            *)
                notify-send "Invalid choice or no action taken. Aborting."
                exit 1
                ;;
        esac
    else
        break
    fi
done

wf-recorder -c libx264rgb -f $HOME/videos/$file_name.mp4

notify-send "Video saved as $file_name.mp4"
