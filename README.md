# rofi-media-wrappers
Take screenshots and screen recordings using **[rofi](https://github.com/davatorium/rofi)**, **[grim](https://sr.ht/~emersion/grim)** and **[wf-recorder](https://github.com/ammen99/wf-recorder)**.
Available as bash or fish script.

## NOTE for `rofi-wfr`
When you run the script, there seems to be no output on success. But it's actually recording the video in the background. In order save the recording, you have to kill the process.

In your window manager, you could create a keyboard binding for a single command that records and stops, i.e.:

```sh
pkill wf-recorder || /path/to/rofi-wfr.sh
```