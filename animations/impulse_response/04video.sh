ffmpeg -y -framerate 20/1 -i final/%03d.png -c:v libx264 -r 20 -pix_fmt yuv420p video_impulse_response.mp4
