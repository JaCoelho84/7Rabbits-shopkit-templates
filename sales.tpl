{#
Description: Promotions Page
#}

{% extends 'base.tpl' %}

{% block content %}

	<div class="content">
		<h1>{{ store.page.sales.title }}</h1>

		{% if store.page.sales.content %}
			<div class="page-content margin-top">
				{{ store.page.sales.content }}
			</div>
		{% endif %}
	</div>

	<div class="content has-products clearfix">

		<section class="products">

			{% for product in products('on_sale limit:16') %}
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
				<p>Não existem produtos em promoção.</p>
			{% endfor %}

		</section>

	</div>

	<nav class="content">
		<hr>
		{{ pagination('on_sale limit:16', 'pagination-centered') }}
	</nav>

{% endblock %}