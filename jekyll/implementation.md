---
layout: default
title: Implementation
date: "2016-07-08"
---

The Implementation
===
The STEAK project extends the open-source software [Asterisk](http://www.asterisk.org), a widely used [PBX](https://en.wikipedia.org/wiki/Business_telephone_system#Private_branch_exchange) server.
The extensions allows to provide one virtual _telephone conferencing space_ per telephone conference with [_3D Audio_](https://en.wikipedia.org/wiki/3D_audio_effect) if desired and technically possible.
Asterisk by itself provides connectivity to almost every telephone technology and is thus backwards compatibility on its own.[^reason]

[^reason]: One reason for choosing [Asterisk](http://www.asterisk.org) over other systems was that a lot of prior knowledge about [Asterisk](http://www.asterisk.org) and its internal signal processing was available in the team. 
And their nice and active community is a plus.

[Asterisk](http://www.asterisk.org) was extended with two features:

###1. Stereo Functionality
So far [Asterisk](http://www.asterisk.org) is only capable of handling mono signals (one channel) and must be extended to be able to transmit spatially rendered stereo signals.
This is achieved by enabling support for the speech and audio codec [OPUS](https://www.opus-codec.org/).
Beside stereo transmission, this codec provides state-of-the-art and can also be used to transmit high-end audio content.
In fact, until now [Asterisk](http://www.asterisk.org) only supported mono signals and thus the internal signal processing needs to be adapted.

###2. Spatial Rendering for Spatial Presentation
In addition to stereo support, the default conference bridge of [Asterisk](http://www.asterisk.org) ([app_confbridge.c](https://github.com/asterisk/asterisk/blob/master/apps/app_confbridge.c)) is extended by spatial rendering capability for binaural representation.

The Code
---

The source code of the STEAK project can be found on [Github](https://github.com/): [https://github.com/SteakConferencing](https://github.com/steakconferencing).

This includes:

* the STEAK-enhanced version of [Asterisk](http://www.asterisk.org), 
* the demo setup with [WebRTC](https://en.wikipedia.org/wiki/WebRTC) clients, and 
* this [website](https://github.com/steakconferencing/website).

The Details
---
In the following, the technical details of the STEAK project are conceptually explained.
For more details, please take a look at the source code.

### Adding the Stereo-capable Codec [OPUS](https://www.opus-codec.org/)
The audio codec [OPUS](https://www.opus-codec.org/) was selected for the implementation of the STEAK project.
This codec allows to transmit _two_ audio signals in one [Real-time Transport Protocol (RTP)](https://en.wikipedia.org/wiki/Real-time_Transport_Protocol) connection[^rtp-profile].
In difference to using two [RTP](https://en.wikipedia.org/wiki/Real-time_Transport_Protocol)-connections, which is possible but a non-standard approach, this avoids to synchronize the received audio streams at the client-side, as the synchronization is handled by the codec itself.
[OPUS](https://www.opus-codec.org/) was choosen over alternatives (e.&thinsp;g., [AMR-WB+](https://en.wikipedia.org/wiki/Adaptive_Multi-Rate_Wideband)) as _(a)_ it is recommended for [WebRTC](https://en.wikipedia.org/wiki/WebRTC), _(b)_ it can be used to send speeech and audio content, and _(c)_ also provides on-the-fly adjustments (e.&thinsp;g., bandwidth and compression adjustments).
Sadly, [Asterisk](http://www.asterisk.org) does not (yet?) include [OPUS](https://www.opus-codec.org/) due to potential issues with patent infringments in the USA and the potential legal risks [(see here)](https://www.ietf.org/mail-archive/web/codec/current/msg03011.html).
Nevertheless, patches for [Asterisk](http://www.asterisk.org) are available that add [OPUS](https://www.opus-codec.org/) support (passthrough and signal processing): [https://github.com/meetecho/asterisk-opus](https://github.com/meetecho/asterisk-opus).

This modification boils down to adding the files `codec/codec_opus.h` and `codec/ex_opus.h` as well as adding the _include flags and linker flags_ for libopus to the build process of [Asterisk](http://www.asterisk.org).

[^rtp-profile]: For an overview on multi-channel enabled RTP profiles see [Wikipedia](https://en.wikipedia.org/wiki/RTP_audio_video_profile).

### Modifying Internal Signal Processing
[Asterisk](http://www.asterisk.org) provides signal processing only for _mono_ signals, as almost any telephone-related system.
Adding stereo to [Asterisk](http://www.asterisk.org) is however straight forward.
Out-of-the-box [Asterisk](http://www.asterisk.org) provides internal (mono) translation between different sampling rates and also codecs.
This functionality enables [Asterisk](http://www.asterisk.org) to connect telephone calls between clients that use different codecs while [Asterisk](http://www.asterisk.org) handles the codec translation.

Required changes are:

#### Signaling
Before an actual telephone call, a client connects to the remote party and signals its interest in establishing a call.
In this so-called _signaling phase_ the client and the remote party inform each other about their interest, their technical capabilities (mainly supported codecs), and connection information.
A client that supports sending and receiving _stereo_ via [OPUS](https://www.opus-codec.org/) needs to annouce this capability and [Asterisk](http://www.asterisk.org) was extended to also annouce, understand, and this capability and flag the connection to be stereo-capable.

In terms of [Asterisk](http://www.asterisk.org), the connection between a client and [Asterisk](http://www.asterisk.org) is denoted as [channel](https://wiki.asterisk.org/wiki/display/AST/Channels).
The data structure describing the channel is extended to contain the information about the stereo capability.
Precisely, this modification is done in struct `ast_trans_pvt` by adding the boolean value `stereo`.

#### Internal Audio Signal Handling
If in the _signaling phase_ stereo capability was annouced by both sides and is going to be used, the internal signal processing of [Asterisk](http://www.asterisk.org) must be aware of this.
Internally [Asterisk](http://www.asterisk.org) uses buffers containing _mono_ audio data (depending on the use: compressed or uncompressed).
These buffers were not modified but instead can now also be filled with _stereo_ audio data (interleaved).
Here, a buffer contains alternatingly one sample per channel (left and right).

A translation between stereo channels and mono channels is also implemented for sake of completeness.
However, this is in general only wasting processing power and both parties should negate to a mono-only transmission.

### Extending the Default Conference Bridge
The default conference bridge ([app_confbridge.c](https://github.com/asterisk/asterisk/blob/master/apps/app_confbridge.c)) mixes the incoming _mono_ signals of all connected channels.
Here, a [voice activity detection](https://en.wikipedia.org/wiki/Voice_activity_detection) algorithm is applied (i.&thinsp;e., non-speaking participants are not mixed), volume adjustments applied, and the resulting _mono_ signals are added together into _one_ mono signal for each participant.
The default conference bridge is modified, so _mono_ channels as well as _stereo_ channels can be connected.
For _stereo_-capable channels a spatial presentation is rendered via convolution using [libfftw](http://www.fftw.org/) for the left ear and right ear.
The rendered signals of all participants are then mixed together by ear, respectively.
All _mono_ channels receive the signals mixed with the same algorithm as the default conferencing bridge while all _stereo_-capable channels will receive a spatial representation.

The following limitation are introduced:

* [HRTFs](https://en.wikipedia.org/wiki/Head-related_transfer_function) are compiled into the module and thus cannot be changed at runtime.
* Only _one_ set of [HRTFs](https://en.wikipedia.org/wiki/Head-related_transfer_function) is used for convolution and thus no individualized [HRTFs](https://en.wikipedia.org/wiki/Head-related_transfer_function) can be used (this also affects compensation for the frequency response of head phones).

One note about scheduling:

No multi-threading is implemented for the STEAK-enhanced conference bridge (or used in [libfftw](http://www.fftw.org/)), i.&thinsp;e., a _running_ conference is rendered using one thread/processor only.
This reduces implementation effort and, furthermore, scheduling for the whole system is handled by [Asterisk](http://www.asterisk.org) itself.

That's all.
