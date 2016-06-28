ffmpeg -y -framerate 10/1 -i rendered/%03d.png -c:v libx264 -r 20 -pix_fmt yuv420p video_sound_field.mp4
