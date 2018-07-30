{#
Description: Home Page
#}

{% extends 'base.tpl' %}

{% block content %}

	{% set featured_products = products('featured limit:8') %}
	{% set new_products = products('new limit:4') %}

	<div class="slideshow-wrapper">

		<div class="text">
			<h3>{{ store.description }}</h3>
			<h4>{{ store.notice }}</h4>
		</div>

		{% if store.image_header_1 or store.image_header_2 or store.image_header_3 %}
			<div class="slideshow visible-desktop">
				{% if store.image_header_1 %}<img src="{{ store.image_header_1 }}" alt="{{ store.name }}">{% endif %}
				{% if store.image_header_2 %}<img src="{{ store.image_header_2 }}" alt="{{ store.name }}">{% endif %}
				{% if store.image_header_3 %}<img src="{{ store.image_header_3 }}" alt="{{ store.name }}">{% endif %}
			</div>
		{% endif %}
	</div>

	{% if featured_products %}

		<div class="home-featured-products">
			<div class="content">
				<h1>Produtos em destaque</h1>
			</div>

			<div class="content has-products clearfix">

				<section class="products">

					{% for product in featured_products %}
					<article class="product-id-{{ product.id }} product">
						<div class="img">
							<a href="{{ product.url }}" class="link-block">{{ product.title }}</a>
							<div class="description">{{ product.description_short }}</div>
							<img src="{{ product.image.full }}" alt="{{ product.title }}" title="{{ product.title }}">
						</div>
						<h3><a href="{{ product.url }}">{{ product.title }}</a></h3>
						<span class="price">

							{% if product.price_on_request == true %}
								Preço sob consulta
							{% else %}
								{% if product.promo == true %}
									{{ product.price_promo | money_with_sign }} &nbsp; <del>{{ product.price | money_with_sign }}</del>
								{% else %}
									{{ product.price | money_with_sign }}
								{% endif %}
							{% endif %}

						</span><br><br>

						{% if product.status == 1 and product.price_on_request == false and not product.option_groups %}
							<a href="{{ product.url }}" class="button"><i class="fa fa-shopping-cart"></i> &nbsp; Comprar</a>
						{% elseif product.option_groups %}
							<a href="{{ product.url }}" class="button"><i class="fa fa-plus"></i> &nbsp; Opções</a>
						{% else %}
							<a href="{{ product.url }}" class="button"><i class="fa fa-plus"></i> &nbsp; Info</a>
						{% endif %}

					</article>

					{% else %}
						<p>Não existem produtos.</p>
					{% endfor %}

				</section>

			</div>
		</div>
	{% endif %}

	{% if new_products %}
		<div class="home-recent-products">
			<div class="content">
				<h1>Novidades</h1>
			</div>

			<div class="content has-products clearfix">

				<section class="products">

					{% for product in new_products %}
					<article class="product-id-{{ product.id }} product">
						<div class="img">
							<a href="{{ product.url }}" class="link-block">{{ product.title }}</a>
							<div class="description">{{ product.description_short }}</div>
							<img src="{{ product.image.full }}" alt="{{ product.title }}" title="{{ product.title }}">
						</div>
						<h3><a href="{{ product.url }}">{{ product.title }}</a></h3>
						<span class="price">

							{% if product.price_on_request == true %}
								Preço sob consulta
							{% else %}
								{% if product.promo == true %}
									{{ product.price_promo | money_with_sign }} &nbsp; <del>{{ product.price | money_with_sign }}</del>
								{% else %}
									{{ product.price | money_with_sign }}
								{% endif %}
							{% endif %}

						</span><br><br>

						{% if product.status == 1 and product.price_on_request == false and not product.option_groups %}
							<a href="{{ product.url }}" class="button"><i class="fa fa-shopping-cart"></i> &nbsp; Comprar</a>
						{% elseif product.option_groups %}
							<a href="{{ product.url }}" class="button"><i class="fa fa-plus"></i> &nbsp; Opções</a>
						{% else %}
							<a href="{{ product.url }}" class="button"><i class="fa fa-plus"></i> &nbsp; Info</a>
						{% endif %}

					</article>

					{% else %}
						<p>Não existem produtos.</p>
					{% endfor %}

				</section>

			</div>
		</div>
	{% endif %}

{% endblock %}