{% extends 'base.tpl' %}

{% block content %}

	<article class="content">
			
		<h1>{{ page.title }}</h1>
		<br>	

		{{ page.content }}

		<hr>

	</article>

{% endblock %}