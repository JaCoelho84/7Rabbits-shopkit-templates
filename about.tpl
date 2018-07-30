{# 
Description: About page
#}

{% extends 'base.tpl' %}

{% block content %}

	<article class="content">
				
		<h1>{{ store.page.about.title }}</h1>
		<br>		
		
		{{ store.page.about.content }}

		<hr>

	</article>

{% endblock %}