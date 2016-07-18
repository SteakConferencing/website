---
layout: default
title: The Demo
date: "2016-07-18"
---

The Demo: [demo.steakconferencing.de](https://demo.steakconferencing.de)
===
The STEAK project provides a &laquo;prodution-ready&raquo; system, so the spatial representation can be experienced without the hassle to setup the whole system.
For reasons of technical simplicity the system is only accessible via [WebRTC](https://webrtc.org/).

__Requirement 1:__ The demo system can only be used with [Google Chrome](https://www.google.com/chrome/) or [Chromium](https://www.chromium.org/) are supported.[^browsersupport]

[^browsersupport]: The demo system only supports [Google Chrome](https://www.google.com/chrome/) or [Chromium](https://www.chromium.org/) as we lack the resources to account for the vast number of (also changing) differences between browser implementations.

__Requirement 2:__ A not heavily firewalled Internet connection (e.&thinsp;g., no cooperate networks).[^firewall]
If you tried the demo system and did not hear anything (i.&thinsp;e., no incoming audio) then you might need to try a different Internet connection.

[^firewall]: A firewall might allow to initiate the call (i.thinsp;e., signaling succeeds) as it is handled through [HTTPS](https://en.wikipedia.org/wiki/HTTPS).
However, then client server try to establish [RTP](https://en.wikipedia.org/wiki/Real-time_Transport_Protocol)-connections to transmit audio.
If the firefall prevents these connections, no audio will be received at both sides.

Beside these, just enter your desired conference number and start talking.

The demo setup is be available at [demo.steakconferencing.de](https://demo.steakconferencing.de).

The system is also reachable using a German land-line number: <a href="tel:+ 49-30/120-64-155">+ 49 30 / 120 64 155</a> (no spatial representation available).


Disclaimer
---
The installed system is _working_, but it is not as heavily **secured** as it would be required for a &laquo;production&raquo; system.

So, use the systems only to talk about things that you would consider _public!_


@Hacking
---
The demo system:

* does not contain (or has access to) any confidential information,
* has its own 100 MBit/s uplink,
* is not connected to other internal systems, and
* is pretty old hardware (~2006: 4GB RAM, 2x Xeon E5-2600).

If you find some _security_ issues, please drop us a message (see [About]({{ site.url }}/about)).

If somebody breaks the demo system, enjoy your _victory_ &ndash; the demo system will be repaired once or twice.
If it happens too often, we will just shutdown the demo system forever.


The Details
---
The demo setup is the STEAK-enhanced [Asterisk](http://www.asterisk.org/) server running on an [Arch Linux](https://www.archlinux.org/).
For easier setup, the demo is implemented using [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol) over [WebRTC](https://webrtc.org/).
This avoids dowloading, installing, and configuring a dedicated client as a [WebRTC](https://webrtc.org/)-capable webbrowser can act as a client.

The setup works as follows:

The [Asterisk](http://www.asterisk.org/) provides a built-in [HTTP](https://en.wikipedia.org/wiki/Web_server) server reachable as [demo.steakconferencing.de](https://demo.steakconferencing.de).
Visiting this webpage with a [WebRTC](https://webrtc.org/)-capabable webbrowser, downloads the demo-client (standalone HTML using [SIP.js](http://sipjs.com/)).
This client then connects to the built-in [HTTP](https://en.wikipedia.org/wiki/Web_server) server and upgrades the connection to a [WebSocket](https://en.wikipedia.org/wiki/WebSocket) connection.
Using this connection, the client registers at the [Asterisk](http://www.asterisk.org/) server ([SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol) register) and on success initiates a call ([SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol) invite).
The [Asterisk](http://www.asterisk.org/) server accepts the incoming call and creates/connects the call to a spatialized conferencing bridge  &ndash; the called number is the identifier of the conference bridge.
Here, both, client and server, establish an unidirectional [RTP](https://en.wikipedia.org/wiki/Real-time_Transport_Protocol) connection for transmission of the speech data.
The server might send spatially rendered signals while the clients only sends the signal of his microphone.
During the call, [DTFM](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling) can be used to activate or deactivate the spatialized representation.

For incoming calls via the German land-line number (it is just [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol)), the procedure is the same except that the server registers at a remote party, which transforms land-line calls to [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol).

For practical reasons, the server is not available using [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol).

The demo system uses the [Fabian HRTFs](https://github.com/SoundScapeRenderer/ssr/tree/master/data/impulse_responses/hrirs).
