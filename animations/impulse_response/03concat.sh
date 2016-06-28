#!/bin/bash

for DEGREE in {1..360}; do

  DEGREEtmp=$DEGREE+180
  DEGREEtmp2=$((DEGREEtmp%360+1))

  printf -v DEGREELST "%03d" $DEGREE
  printf -v DEGREEHRIR "%03d" $DEGREEtmp2

  convert rendered/hrir_$DEGREEHRIR.png -background white rendered/listener_speaker_$DEGREELST.png -gravity center +append  final/$DEGREELST.png
done