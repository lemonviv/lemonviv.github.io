<h2 id="publications-heading">Selected Publications</h2>
<ol class="publication-list">
  {% for paper in site.data.publications.main %}
  <li>
    <div class="paper-title">{% if paper.pdf %}<a href="{{ paper.pdf }}">{{ paper.title }}</a>{% else %}{{ paper.title }}{% endif %}</div>
    <div class="paper-authors">{{ paper.authors }}</div>
    <div class="paper-venue"><em>{{ paper.conference }}</em></div>
    <div class="paper-links">
      {% if paper.pdf %}<a href="{{ paper.pdf }}">PDF</a>{% endif %}
      {% if paper.code %}<a href="{{ paper.code }}">Code</a>{% endif %}
      {% if paper.page %}<a href="{{ paper.page }}">Project Page</a>{% endif %}
      {% if paper.bibtex %}<a href="{{ paper.bibtex }}">BibTex</a>{% endif %}
      {% if paper.notes %}<strong class="paper-note">{{ paper.notes }}</strong>{% endif %}
      {% if paper.others %}{{ paper.others }}{% endif %}
    </div>
  </li>
  {% endfor %}
</ol>
