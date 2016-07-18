---
layout: default
title: The FAQ
date: "2016-06-23"
---
The FAQ
===

The STEAK Project
---

### Is there funding for the project?

Yes.

The project is funded via the [SoftwareCampus](http://www.softwarecampus.de/).
Funding period is 2016-01-01 until 2016-12-31.

### Are the STEAK-modifications going to merged back to Asterisk?

We hope so.

It is the only option to maintain the project outcome beyond 2016-12-31.

### Who came up with the idea to name the project "STEAK"?

An acronym generator...
and we were keen on a fancy project name.

<hr />

The Demo
---

### Which webbrowser are supported for the demo?

Thanks for asking.

We can only support [Google Chrome](https://www.google.com/chrome/) and [Chromium](https://www.chromium.org/).
Although [WebRTC](https://webrtc.org/) is already some years old, it is not yet stable.
the issue is that the major webbrowser do not provide the same feature set (for example [rtcpeerconnection](http://caniuse.com/#feat=rtcpeerconnection)) and furthermore behave differently.

We just do not have the (spare) time for this.


### Can I use the demo system for my daily life?

Please don't.

Just keep in mind that this system is not _production-ready_.
It is neither especially __secured__ nor can we guarantee its availability.

In fact, we use pretty old hardware: might fail at any moment.


### The demo system is offline. When is going to be online again?

Don't know.

Depends on the reason it is offline.


### How can I report an issue with demo?

Sorry hearing about this.

Please verify that this is __not__ an issue with:

* _(a)_ your webbrowser: [Google Chrome](https://www.google.com/chrome/) and [Chromium](https://www.chromium.org/), and
* _(b)_ your Internet connection: firewalls etc., and
* _(c)_ check the [_console output_](https://developer.chrome.com/devtools) of your webbrowser.

If your issue persists please contact create a _bug report_ ([https://github.com/steakconferencing/](https://github.com/steakconferencing/)) or contact us directly (see [About]({{ site.url }}/about)).

<hr />

The Website
---

### Why does the website looks weird in my webbrowser?

Most likely your webbrowser does not support [HTML5](https://en.wikipedia.org/wiki/HTML5) with [CSS3](https://en.wikipedia.org/wiki/Cascading_Style_Sheets#CSS_3) and [SVG](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics).

The videos are coded in [H.264](https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC).


### Who came up with the style of the website?
The style of the webpage is based upon a template called [HYDE](https://github.com/poole/hyde).

We just changed some things.
