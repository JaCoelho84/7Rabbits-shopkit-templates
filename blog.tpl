{# 
Description: Blog page
#}

{% extends 'base.tpl' %}

{% block content %}
	
	<section class="content">

		<h1>Blog</h1>
		<br>
			
		{% for post in blog_posts("limit:9") %} 
				
			<article class="row-fluid break-word">
				
				<div class="span8">
					<h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
					<p><small class="muted"><em>Escrito em <strong>{{ post.date|date("d \\d\\e M. \\d\\e Y") }}</strong></em></small></p>
					{{ word_limiter(post.excerpt, 100, ' ... <a href="' ~ post.url ~ '">Ler mais</a>') }}
				</div>
				
				{% if post.image %}
					<p class="span4"><a href="{{ post.url }}"><img class="boxed" src="{{ post.image.thumb }}" alt="{{ post.title }}"></a></p>
				{% endif %}
				
			</article>
			
			<hr>
			
		{% else %}
			
			<h5>Não existem entradas no blog.</h5>
			
		{% endfor %}

		{{ pagination("limit:9") }}	

	</section>


{% endblock %}