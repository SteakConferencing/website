---
layout: default
title: Theory
date: "2016-06-02"
---

The Theory of Spatial Rendering
===

Sound field
---
Positioning sound source(s) in an environment results in a _sound field_.
This sound field depends on the position of sound sources, their characteristics, and also reflections of sound waves.
The sound waves of individual sources can affect each other depending on their characteristic, position, and timing, i.&thinsp;e., elimate each other or amplify each other.

<figure>
  <video src="{{ site.baseurl }}/images/video_sound_field.mp4" controls loop style="width: 100%"></video>
  <figcaption><b>Video:</b> Sound field for two non-continuous sound sources.<br />
  <small>Data, and animation courtesy to <a href="https://github.com/hagenw/phd-thesis/blob/master/01_introduction/fig1_02/itd_ild.svg">Hagen Wierstorf</a>.</small></figcaption>
</figure>

A sound field inherently contains spatial information about each sound source.
The spatial information can be derived to a certain degree by sampling the sound field using multiple microphones.
For constant sound sources signals, also one microphone can used while changing the position and, for unidirectional microphones, the direction of the microphone over time.
Evaluating the difference between the recorded signals, allows to estimate the position of individual sound sources.

Spatial Hearing
---
Humans are able to extract spatial information of a sound field using their ears.
A human ear is, in fact, a biologically microphone covered with a [pinna](https://en.wikipedia.org/wiki/Auricle_(anatomy)).
Using both ears, humans can derive spatial information of sound sources in their environment.
Depending on the position of a sound source, the sound waves reaching each ear are different (except if the source is directly in front or in the back of the head), as sound waves are traveling different paths to each ear.
These differences occur in timing (_Interaural Time Difference_, [ITD](https://en.wikipedia.org/wiki/Sound_localization#Lateral_information_.28left.2C_ahead.2C_right.29)), level in terms of volume (_Interaural Level Difference_, [ILD](https://en.wikipedia.org/wiki/Sound_localization#Lateral_information_.28left.2C_ahead.2C_right.29)), and frequency.
Differences in timing occur if the distance between the sound source and both ears are not equal.
A longer distance requires more time for sound waves to reach the ear and also reduces their energy (volume).
Differences in frequency for example occur due to objects that are accoustically not transparent.
If such objects are between the sound source and the ear, the sound waves cannot pass freely and this might block some frequency spectra partly or even completely (such as the head).
These characteristics might enable to derive the direction of a sound source relative the rotation of the head to a certain degree.
The distance of a sound source can be determined by the level of the signals reaching the ears (if a ground truth about a sound source is available), and by timing differences of reflections of the sound waves.

However, human hearing is not perfect.
For example, the angular resolution is not uniformly precise.
The highest resolution (horizontally) is available in front of the head (1-2 degrees) while to left and right the resolution decreases to up to 30 degrees.
In the vertical, the angular resolution is even lower.

Spatial Rendering using a Pair of Headphones
---
The impression of spatiality of one or more sound source can be recreated using a pair of headphones.
One approach is to create [binaural recordings](https://en.wikipedia.org/wiki/Binaural_recording) of a real sound enviroment.
Here, a [dummy head](https://en.wikipedia.org/wiki/Dummy_head_recording), representing a human head with two artificial ears, is used to record the sound field at the desired position (potentially with movements if desired).
Presenting the recorded signal of each ear binaurally via a pair of headphones to a person, enables this person to experience the sound field.
The listener experiences the sound field, as he would have been at the position of the dummy head includings its motion and head rotation.

<figure>
  <video src="{{ site.baseurl }}/images/video_impulse_response.mp4" controls loop style="width: 100%"></video>
  <figcaption><b>Video:</b> Impulse responses for both ears depending on head rotation for a sound source at 0&deg;, e.g., in front of the listener.<br />
  <small>Data, images, and animation courtesy to <a href="http://www.gnuplotting.org/animation-iii-video-revisited/">Gnuplotting.org</a> and <a href="https://github.com/hagenw/phd-thesis/blob/master/01_introduction/fig1_02/itd_ild.svg">Hagen Wierstorf</a>.</small></figcaption>
</figure>

A spatial representation can also be _rendered_.
If this is done in real-time (here in terms of fast enough) then head rotation and position changes of the listener can be taken into account.
This is simulated by rendering the resulting signals of the left and right ear for all sound sources in the simulated sound field depending on their position, direction, and also reflections.
Basically, this adds the spatial cues to the signals (e.&thinsp;g., [ITD](https://en.wikipedia.org/wiki/Sound_localization#Lateral_information_.28left.2C_ahead.2C_right.29) and [ILD](https://en.wikipedia.org/wiki/Sound_localization#Lateral_information_.28left.2C_ahead.2C_right.29)), which can then be processed by the human hearing system.

Spatial rendering can be conducted using [convolution](https://en.wikipedia.org/wiki/Convolution).
Here, the signal of a sound source is convolved for each ear using a so-called _Head Related Transfer Function_ ([HRTF](https://en.wikipedia.org/wiki/Head-related_transfer_function)).
The [HRTF](https://en.wikipedia.org/wiki/Head-related_transfer_function) describes the modifications applied to the signal from a sound source depending on its relative position to the ear.
The [HRTF](https://en.wikipedia.org/wiki/Head-related_transfer_function) is actually the _Fourier Transform_ of the _Head Related Impulse Response_ ([HRIR](https://en.wikipedia.org/wiki/Head-related_transfer_function)).
For convolution, the _Fourier Transform_ of the source signal is multiplied with the [HRTF](https://en.wikipedia.org/wiki/Head-related_transfer_function) and then the inverse Fourier transformation applied.
For a binaural representation, this is conducted for each ear individually.
Presenting these two signals at the same time to each ear correctly should result a spatial representation for a listener.
The distance of a sound source to the listener is simulated by adjusting the loudness (i.&thinsp;e.,  with an increasing distance a sound source gets less loud).
Multiple sound sources at the same time can be presented by mixing (i.&thinsp;e. adding) the convoluted signals of each ear.

### Practical Limitations

Providing a spatial representation using a pair of headphones has some practical issues.
This includes delay due to spatial rendering (problematic if head movements need to be taken into account), differences in audio equipment (e.&thinsp;g., the frequency response of headphones is not identical), and differences between humans and their individual learned spatial audio processing.
While delay can be reduced (e.&thinsp;g., [overlapp-add method](https://en.wikipedia.org/wiki/Overlap%E2%80%93add_method)) and the differences in frequency response of headphones can be compensated to a certain degree, the signal modifications due to individual pinna shapes, ear distance, hairstyle, and also reflections of the human body can only be accounted for to a certain degree.
In fact, signal modifications due to differing pinna shapes can be accounted for by creating individualized [HRTFs](https://en.wikipedia.org/wiki/Head-related_transfer_function), often [HRTFs](https://en.wikipedia.org/wiki/Head-related_transfer_function) are derived using a _standard_ pinna are sufficiently to provide a satifisfying spatial representation.

Another practical issue occurs due to the fact that humans move their head to explore a their sound environment.
This allows to avoid front-back confusion, i.&thinsp;e., it is hard to determine if a sound source is in front or back of the listener as the signal modifications are very similar (same [ILD](https://en.wikipedia.org/wiki/Sound_localization#Lateral_information_.28left.2C_ahead.2C_right.29) and [ITD](https://en.wikipedia.org/wiki/Sound_localization#Lateral_information_.28left.2C_ahead.2C_right.29)).
In addition, also improved angular resolution in front of the listener can be exploited by rotating the head towards the sound source.
Moreover, also a listener might shift their position in a sound field to explore it.
The absence of the ability to move or rotate the head might limits the usefulness of a spatial representation.

Further Reading
---
* Blauert, [_Spatial Hearing_](https://mitpress.mit.edu/books/spatial-hearing), MIT Press.
