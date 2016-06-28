#!/bin/bash

for DEGREE in {001..360}; do
#  convert -rotate $DEGREE -background transparent listener.tiff -distort SRT $DEGREE rendered/listener_$DEGREE.png
  convert listener.png -distort SRT $DEGREE rendered/listener_$DEGREE.png
  convert speaker.png -background white -resize 64x64 rendered/listener_$DEGREE.png -gravity center -append rendered/listener_speaker_$DEGREE.png
done