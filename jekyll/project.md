---
layout: default
title: The Project
date: "2016-06-28"
---

The Project
===

In the STEAK project, a telephone conferencing system is implemented that _(a)_ provides spatial audio and _(b)_ is legacy compatible.
This system will provide a spatial representation (i.&thinsp;e., ["3D audio"](https://en.wikipedia.org/wiki/3D_audio_effect)) of a telephone conference using binaural synthesis (i.&thinsp;e., a signal for each ear is computed and presented using a pair of headphones).

The STEAK project has two goals:
---

### 1. Implementation of a _real_ spatial conferencing system

In the STEAK project, a legacy compatible spatial telephone conference system is implemented.
If participants join a conference via [VoIP](https://en.wikipedia.org/wiki/Voice_over_IP) ([WebRTC](https://en.wikipedia.org/wiki/WebRTC) or [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol)) and are capable of reproducing _stereo signals_ via a pair of headphones, then a spatial presentation can be made available to them.
This system is legacy compatible, i.&thinsp;e., so participants can also join a conference call via a standard telephone.
These participants then only receive a standard (mono-mixed) representation, which does not contain spatial cues.

The system will be implemented using open-source components only and the final implementation is going to be released as open-source.

### 2. Research on advantages of spatial conferencing

Spatial representation for telephone conferencing is expected to reduce the effort for participants to follow the conversation.
In the context of the STEAK project, we are going to investigate if telephony-related artifacts, such as background noise, can be attributed to individual participants of a telephone conference.

STEAK has one limitation: no headtracking
---
The telephone conferencing system will be implemented as a _centralized conferencing bridge_ (i.&thinsp;e., binaural rendering takes place at the _conference server_), and clients will only playback the rendered binaural signals.
Using a centralized conferencing bridge avoids sendings the signals of all participants to all other participants and thus less bandwidth is required.
However, the introduced delay of the central rendering and transmission prevents accounting for head rotation of participants.
In fact, humans explore their sound environment by rotating their head and thus can select and focus on individual sound sources.
This requires that the head rotation can be measured precisely and, if the head rotates to render the signals accordingly.
This requires the use of a headtracker and the virtual sound scape needs to be adjusted almost instantanously.
Due to the implementation of _centralized conferencing bridge_, such a low delay cannot be provided as the rotation must be measured, send to the server, rendered by the server, and send the rendered signals to the client.

Thus, _headtracking_ is out of scope.
