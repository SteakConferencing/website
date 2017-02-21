The STEAK Project
===

In the STEAK project, we are implementing a [telephone conferencing system](https://en.wikipedia.org/wiki/Conference_call).
In difference to widely available system, this system will be providing [3D audio](https://en.wikipedia.org/wiki/3D_audio_effect) when headphones are used.

For more details, please check out:

1. [The Project]({{ site.baseurl }}/project#content),
2. [The Theory of Spatial Rendering]({{ site.baseurl }}/theory#content),
3. [The Implementation]({{ site.baseurl }}/implementation#content), and
4. [The Demo]({{ site.baseurl }}/demo#content).

Status
---

The project is finished while the modifications are going to be integrated into [Asterisk](http://www.asterisk.org).

News <small>([RSS Feed]({{ site.baseurl }}/atom.xml))</small>
---

{% for post in site.posts %}
<article>
  <h3>
    <i><time datetime="{{ post.date | date_to_string }}">{{ post.date | date: "%Y-%m-%d" }}</time>:</i> <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
  </h3>

  {{ post.content }}
</article>
{% endfor %}
