{#
Description: Product Page
#}

{% extends 'base.tpl' %}

{% block content %}

	<article class="content product" itemscope itemtype="http://schema.org/Product">

		<p class="breadcrumbs">
			<a href="/"><i class="fa fa-home"></i></a> › {{ product.title }}
		</p>
		<br>

		<div class="row-fluid">

			<div class="span6">

				<h1 itemprop="name">{{ product.title }}</h1>

				{% if product.reference %}
					<small class="muted light">Referência: <span itemprop="sku">{{ product.reference }}</span></small>
				{% endif %}
				<br><br>

				<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
					<meta itemprop="priceCurrency" content="{{ store.currency }}" />
					<p class="price">
						{% if product.price_on_request == true %}
							<span itemprop="price" class="data-product-price">Preço sob consulta</span> &nbsp; 
							<del></del>
						{% else %}
							{% if product.promo == true %}
								<span itemprop="price" class="data-product-price">{{ product.price_promo | money_with_sign }}</span> &nbsp; 
								<del>{{ product.price | money_with_sign }}</del>
							{% else %}
								<span itemprop="price" class="data-product-price">{{ product.price | money_with_sign }}</span> &nbsp; 
								<del></del>
							{% endif %}
						{% endif %}
					</p>

					<small class="muted data-promo-percentage">
						{% if product.price_promo_percentage == true %}
							Desconto de {{ product.price_promo_percentage }}%
						{% endif %}
					</small>
				</div>

				<br>

				<div class="row-fluid">
					<div class="span11">

						{{ form_open_cart(product.id, { 'class' : 'add-cart' }) }}

							<h4>Adicionar ao Carrinho</h4>

							{% if product.status == 1 %}

								{% if product.option_groups %}
									{% for option_groups in product.option_groups %}

										<h6>{{ option_groups.title }}</h6>

										<select class="input-block-level select-product-options" name="option[]">
											{% for option in option_groups.options %}
												<option value="{{ option.id }}" data-title="{{ option.title }}">
													{{ option.title }}

													{% if option.price_on_request == true %}
														- Preço sob consulta
													{% else %}
														{% if option.price is not null %}
															{% set option_display_price = option.promo ? option.price_promo : option.price %}
															- {{ option_display_price | money_with_sign }}
														{% endif %}
													{% endif %}
												</option>
											{% endfor %}
										</select>

									{% endfor %}
								{% endif %}

								<br>
								<div class="data-product-info">
									<small>Quantidade</small><br>

									<div class="form-inline">
										<input type="number" class="span2" name="qtd" value="1" {% if product.stock.stock_sold_single %} data-toggle="tooltip" data-placement="bottom" data-original-title="Só é possível comprar 1 unidade deste produto." title="Só é possível comprar 1 unidade deste produto." readonly {% endif %}>
										<button class="button" type="submit">
											<i class="fa fa-shopping-cart"></i> &nbsp;Comprar
										</button>
									</div>

									{% if product.tax > 0 %}
										<hr>
										{% if store.taxes_included == false %}
											<span class="muted">Ao preço acresce IVA a {{ product.tax }}%</span>
										{% else %}
											<span class="muted">IVA incluído</span>
										{% endif %}
									{% endif %}

									{% if product.stock.stock_show %}
										<hr>
										<h6>Stock</h6>
										<em class="muted"><span class="data-product-stock_qty">{{ product.stock.stock_qty }}</span> unidades em stock</em>
									{% endif %}
								</div>

								<div class="data-product-on-request">
									<a class="button price-on-request" href="{{ site_url('contact') }}?p={{ product.title }}">
										<i class="fa fa-envelope"></i> &nbsp;Contactar
									</a>
								</div>

							{% elseif product.status == 3 %}
								<div class="alert alert-info">O produto encontra-se sem stock.</div>
							{% elseif product.status == 4 %}
								<div class="alert alert-info">O produto estará disponível brevemente.</div>
							{% endif %}

							{% if user.is_logged_in %}
								<div class="wishlist">
									<hr>
									{% if not product.wishlist.status %}
										<a href="{{ product.wishlist.add_url }}" class="text-muted"><i class="fa fa-heart fa-fw"></i> Adicionar à wishlist</a>
									{% else %}
										<a href="{{ product.wishlist.remove_url }}" class="text-muted"><i class="fa fa-heart-o fa-fw"></i> Remover da wishlist</a>
									{% endif %}
								</div>
							{% endif %}

						{{ form_close() }}

						{% if product.description %}
							<hr>
							<div class="product-description break-word" itemprop="description" content="{{ description }}" >
								{{ product.description }}
							</div>
						{% endif %}

					</div>
				</div>

			</div>

			<div class="span5 offset1 product-gallery">

				<a href="{{ product.image.full }}" class="product-image lightwindow"><img src="{{ product.image.full }}" alt="{{ product.title }}" itemprop="image"></a>

				{% if product.images %}

					<div class="row-fluid thumbs">
						<div class="span3">
							<a href="{{ product.image.full }}" class="lightwindow"><img src="{{ product.image.square }}" alt="{{ product.title }}"></a>
						</div>
						{% for thumb in product.images %}
							<div class="span3">
								<a href="{{ thumb.full }}" class="lightwindow"><img src="{{ thumb.square }}" alt="{{ product.title }}"></a>
							</div>
							{% if loop.index0%3 == 2 %}</div><div class="row-fluid thumbs">{% endif %}
						{% endfor %}
					</div>

				{% endif %}

			</div>

		</div>

		<hr>

		{% if product.file %}
			<a target="_blank" href="{{ product.file }}" class="colorless book"><i class="fa fa-download"></i> Download Ficheiro Anexo</a>
			<br><br>
		{% endif %}

		{% if product.video_embed_url %}
			<div class="video-wrapper">
				<iframe src="{{ product.video_embed_url }}" height="620"></iframe>
			</div>
		{% endif %}

		<div class="row-fluid">

			<div class="span2">
				<div class="fb-like" data-send="true" data-width="" data-show-faces="false" data-font="tahoma" data-layout="button_count" data-action="like"></div>
			</div>

			<div class="visible-desktop">
				<div class="span1">
					<div class="g-plusone" data-size="medium"></div>
				</div>

				<div class="span1">
					<a href="http://twitter.com/share" class="twitter-share-button" data-count="none" data-lang="pt">Tweet</a>
				</div>

				<div class="span1">
					<a href="//pinterest.com/pin/create/button/?url={{ product.url }}&amp;media={{ product.image.full }}&amp;description={{ description }}" data-pin-do="buttonPin" data-pin-config="beside"><img src="//assets.pinterest.com/images/pidgets/pin_it_button.png" alt="Pin it"></a>
				</div>
			</div>

		</div>

		<br>

		{% if apps.facebook_comments.comments_products %}
			<div class="boxed hidden-phone">
				<div class="fb-comments" data-href="{{ product.permalink }}" data-num-posts="5" data-colorscheme="light" data-width="100%"></div>
			</div>
		{% endif %}

	</article>

	<script>
		Modernizr.load([
			{load: '//platform.twitter.com/widgets.js'},
			{load: '//apis.google.com/js/plusone.js'},
			{load: '//assets.pinterest.com/js/pinit.js'}
		]);
	</script>

{% endblock %}