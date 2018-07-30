{#
Template Name: Shopper
Author: Shopkit
Version: 3.0
Description: This is the base layout. It is included in every page with this code {% extends 'base.tpl' %}
#}

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>{{ title }}</title>
	<meta name="description" content="{{ description }}">
	<meta name="keywords" content="{{ tags }}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">

	{% if store.show_branding %}
		<meta name="author" content="Shopkit">
	{% endif %}

	{% if store.translate_meta %}
		<meta name="google-translate-customization" content="{{ store.translate_meta }}">
	{% endif %}

	<!-- Facebook Meta -->
	<meta property="og:site_name" content="{{ store.name }}">
	<meta property="og:type" content="website">
	<meta property="og:title" content="{{ title }}">
	<meta property="og:description" content="{{ description }}">
	<meta property="og:url" content="{{ current_url() }}">

	{% if image %}
		<meta property="og:image" content="{{ image }}">
	{% endif %}

	{% if apps.facebook_comments.username %}
		<meta property="fb:admins" content="{{ apps.facebook_comments.username }}">
	{% endif %}
	<!-- End Facebook Meta -->

	{% if store.favicon %}
		<link rel="shortcut icon" href="{{ store.favicon }}">
	{% endif %}

	<link rel="alternate" href="{{ site_url('rss') }}" type="application/rss+xml" title="{{ store.name }}">
	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
	<link rel="stylesheet" href="{{ store.assets.css }}">

	{% if store.custom_css %}
		<style>{{ store.custom_css }}</style>
	{% endif %}

	<!--[if IE 7]>
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/3.2.0/css/font-awesome-ie7.min.css">
	<![endif]-->

	<script src="{{ assets_url('js/common/modernizr-2.7.1.min.js')}}"></script>
	<script src="//drwfxyu78e9uq.cloudfront.net/assets/common/vendor/jquery/1.9.1/jquery.min.js"></script>

	{{ head_content }}

</head>
<body class="template-shopper {{ css_class }} {{ product.price_on_request ? 'price-on-request' }}">

	<div class="container">

		<header class="inner">
			<div class="row-fluid">

				<div class="span6">
					{% if store.logo %}
						<a href="/" class="logo"><img src="{{ store.logo }}" alt="{{ store.name }}"></a>
					{% else %}
						<h1 class="logo"><a href="/">{{ store.name }}</a></h1>
					{% endif %}
				</div>

				<div class="span6">

					<div class="cart-wrapper ">

						<a class="cart pull-right" href="{{ site_url('cart') }}">
							<i class="fa fa-shopping-cart"></i> &nbsp; &nbsp; <span class="cart-num-products"><strong>{{ cart.item_count }}</strong> produtos &nbsp; &ndash; &nbsp; </span><strong class="color">{{ cart.subtotal | money_with_sign }}</strong>
						</a>

						<div class="popover bottom show">
							<div class="arrow"></div>
							<h3 class="popover-title">Carrinho de Compras <a class="close" href="#">&times;</a></h3>
							<div class="popover-content">

								{% if cart.items %}
									<ul class="unstyled">
										{% for item in cart.items %}
											<li><strong class="color color-dark">{{ item.qty }}x</strong> <a href="{{ item.product_url }}">{{ item.title }}</a> &ndash; <span class="price">{{ item.price | money_with_sign }}</span></li>
										{% endfor %}
									</ul>

									<div class="cart-info">
										<a href="{{ site_url('cart') }}"><strong>Ver carrinho <i class="fa fa-angle-right"></i></strong></a>
									</div>

								{% else %}
									<p class="centered">Não existem produtos no carrinho</p>
								{% endif %}

							</div>
						</div>
					</div>

					{% if store.settings.cart.users_registration != 'disabled' %}
						{% if user.is_logged_in %}
							<a href="{{ site_url('account') }}" class="link-account"><i class="fa fa-user"></i> &nbsp; &nbsp; Olá <strong>{{ user.name|first_word }}</strong></a>
						{% else %}
							<a href="#" class="trigger-shopkit-auth-modal link-signin"><i class="fa fa-sign-in"></i> &nbsp; &nbsp; Login</a>
						{% endif %}
					{% endif %}

				</div>

			</div>

		</header>

		<nav class="navbar navbar-inverse">

			<div class="navbar-inner">

				<div class="container">

					<a class="btn btn-navbar">
						<span class="fa fa-bars"></span>
					</a>

					<div class="nav-collapse collapse">
						<ul class="nav">
							{% for primary_navigation in store.navigation.primary %}
								<li class="menu-{{ primary_navigation.menu_text|slug }}"><a href="{{ primary_navigation.menu_url }}" {{ primary_navigation.target_blank ? 'target="_blank"' }}>{{ primary_navigation.menu_text }}</a></li>
							{% endfor %}
						</ul>

						{% if apps.google_translate %}
							<a href="#modal-language" class="pull-right btn-language visible-desktop" role="button"  data-toggle="modal"><i class="fa fa-flag"></i></a>
						{% endif %}

						<form class="navbar-search pull-right" action="{{ site_url('search') }}">
							<input type="text" class="search-query span2" placeholder="Pesquisar" name="q">
						</form>

						<div class="categories pull-right {% if apps.google_translate %}has-language{% endif %}">
							<a href="#">Categorias <i class="fa fa-angle-down"></i></a>

							<ul class="unstyled">
								<li class="menu-catalog {% if (current_page == 'catalog') %} active {% endif %}">
									<a href="{{ site_url('catalog') }}">Todos os produtos</a>
								</li>

								{% for products_category in categories %}
									<li {% if (category.id == products_category.id) %}class="active"{% endif %}>

										<a data-total-products="{{ products_category.total_products }}" href="{% if products_category.total_products > 0 or products_category.children == false %}{{ products_category.url }} {% else %}#{% endif %}" data-toggle="collapse" data-target="#category_{{ products_category.id }}">{{ products_category.title }}</a>

										{% if products_category.children %}
											<ul id="category_{{ products_category.id }}" class="collapse {% if (category.parent == products_category.id or category.id == products_category.id or category.id == products_category.id) %}in{% endif %}">

												{% for children in products_category.children %}
													<li {% if (category.id== children.id) %}class="active"{% endif %}>
														<a href="{{ children.url }}">{{ children.title }}</a>
													</li>
												{% endfor %}
											</ul>
										{% endif %}
									</li>
								{% endfor %}
							</ul>

						</div>

					</div>

				</div>
			</div>

		</nav>

		{% block content %}{% endblock %}

		<footer>

			<div class="blocks">
				<div class="row-fluid">

					{% if apps.facebook_page %}
					<div class="span3 hidden-phone">
						<h2>Facebook</h2>
						<div class="fb-page" data-href="{{ apps.facebook_page.facebook_url }}" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="{{ apps.facebook_page.facebook_url }}" class="fb-xfbml-parse-ignore"><a href="{{ apps.facebook_page.facebook_url }}">Facebook</a></blockquote></div>
					</div>
					{% endif %}

					{% if apps.newsletter %}
						<div class="span3">
							<h2>Newsletter</h2>

							<p>Inscreva-se na nossa newsletter para receber todas as novidades no seu e-mail.</p>
							<br>
							{{ form_open('newsletter/register') }}
								<input name="nome_newsletter" type="text" placeholder="Nome" class="input-block-level" required="">
								<input name="email_newsletter" type="email" placeholder="E-mail" class="input-block-level" required="">
								<button class="btn btn-inverse" type="submit">Registar</button>
							{{ form_close() }}
						</div>
					{% endif %}

					{% if store.navigation.secondary %}
						<div class="span3">
							<h2>Páginas</h2>
							{% for secondary_navigation in store.navigation.secondary %}
								<p class="menu-{{ secondary_navigation.menu_text|slug }}"><a href="{{ secondary_navigation.menu_url }}" {{ secondary_navigation.target_blank ? 'target="_blank"' }}>{{ secondary_navigation.menu_text }}</a></p>
							{% endfor %}
						</div>
					{% endif %}

					<div class="span3">
						<h2>Contactos</h2>

						{% if store.show_email %}
							<p><strong>E-mail</strong><br>
								{{ safe_mailto(store.email) }}</p>
						{% endif %}

						{% if store.phone %}
							<p><strong>Telefone</strong><br>
							{{ store.phone }}</p>
						{% endif %}

						{% if store.cellphone %}
							<p><strong>Telemóvel</strong><br>
							{{ store.cellphone }}</p>
						{% endif %}

						{% if store.address %}
							<p><strong>Morada</strong><br>
							{{ store.address|nl2br }}</p>
						{% endif %}
					</div>
				</div>
			</div>

			<div class="row-fluid">
				<div class="span6 copyright">
					&copy; <strong>{{ store.name }}</strong> {{ "now"|date("Y") }}. Todos os direitos reservados.
					<span class="footer-nav">
						<br><br>
						{% for primary_navigation in store.navigation.primary %}
							<a href="{{ primary_navigation.menu_url }}" {{ primary_navigation.target_blank ? 'target="_blank"' }}>{{ primary_navigation.menu_text }}</a>{{ not loop.last ? ' &nbsp; | &nbsp; ' }}
						{% endfor %}
					</span>
				</div>

				{% if store.footer_info %}
					<div class="span6 footer-info copyright">
						{{ store.footer_info|nl2br }}
					</div>
				{% endif %}
			</div>

			<div class="row-fluid">
				<div class="span6 copyright footer-icons">
					<div class="payment-logos">
						{% spaceless %}
							{% if store.payments.paypal.active %}
								<img src="{{ assets_url('templates/assets/common/icons/payments/paypal-inverted.png') }}" alt="Paypal" title="Paypal">
							{% endif %}

							{% if store.payments.multibanco.active %}
								<img src="{{ assets_url('templates/assets/common/icons/payments/multibanco-inverted.png') }}" alt="Multibanco" title="Multibanco">
							{% endif %}

							{% if store.payments.on_delivery.active %}
								<img src="{{ assets_url('templates/assets/common/icons/payments/contra-reembolso-inverted.png') }}" alt="Contra Reembolso" title="Contra Reembolso">
							{% endif %}

							{% if store.payments.bank_transfer.active %}
								<img src="{{ assets_url('templates/assets/common/icons/payments/transferencia-bancaria-inverted.png') }}" alt="Transferência Bancária" title="Transferência Bancária">
							{% endif %}

							{% if store.payments.pick_up.active %}
								<img src="{{ assets_url('templates/assets/common/icons/payments/levantamento-inverted.png') }}" alt="Levantamento nas instalações" title="Levantamento nas instalações">
							{% endif %}
						{% endspaceless %}
					</div>
				</div>

				<div class="span6 copyright footer-icons">
					<div class="social-networks">
						{% if store.facebook %}
							<a target="_blank" href="{{ store.facebook }}" class="facebook" title="Facebook"><i class="fa fa-facebook"></i></a>
						{% endif %}

						{% if store.twitter %}
							<a target="_blank" href="{{ store.twitter }}" class="twitter" title="Twitter"><i class="fa fa-twitter"></i></a>
						{% endif %}

						{% if store.instagram %}
							<a target="_blank" href="{{ store.instagram }}" class="instagram" title="Instagram"><i class="fa fa-instagram"></i></a>
						{% endif %}

						{% if store.pinterest %}
							<a target="_blank" href="{{ store.pinterest }}" class="pinterest" title="Pinterest"><i class="fa fa-pinterest"></i></a>
						{% endif %}

						<a href="{{ site_url('rss') }}" class="rss" title="RSS"><i class="fa fa-rss"></i></a>
					</div>
				</div>

			</div>

			{% if store.is_ssl %}
				<div class="text-center" style="margin-top:30px;"><img src="{{ assets_url('templates/assets/common/icons/secure-site-ssl.png') }}" alt="Site Seguro" title="Site Seguro" style="height: 30px;"></div>
			{% endif %}

			{% if store.show_branding %}
				<p class="powered-by" style="margin-top:60px; text-align: center; opacity:0.25; color: #fff; font-size: 9px;">Powered by<br><a href="https://shopk.it/?utm_source={{ store.username }}&amp;utm_medium=referral&amp;utm_campaign=Shopkit-Stores-Branding" target="_blank"><img src="https://drwfxyu78e9uq.cloudfront.net/assets/frontend/img/logo-shopkit-white.png" alt="Shopkit" title="Powered by Shopkit" style="height:25px;"></a></p>
			{% endif %}

		</footer>

	</div>

	{# Events #}
	{% if events.wishlist %}
		<div class="modal hide fade modal-alert">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Wishlist</h3>
			</div>
			<div class="modal-body">
				{% if events.wishlist.added %}
					<p>O produto foi adicionado à wishlist</p>
				{% elseif events.wishlist.removed %}
					<p>O produto foi removido da wishlist</p>
				{% endif %}
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Fechar</a>
			</div>
		</div>
	{% endif %}

	{% if events.cart %}
		<div class="modal hide fade modal-alert">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Carrinho de Compras</h3>
			</div>
			<div class="modal-body">
				{% set button_label = 'Fechar' %}

				{% if events.cart.stock_qty or events.cart.stock_sold_single or events.cart.no_stock %}

					{% if events.cart.stock_qty %}
						<p>Não existe stock suficiente do produto</p>
					{% endif %}

					{% if events.cart.stock_sold_single %}
						<p>Só é possível comprar <strong>1 unidade</strong> do produto <strong>{{ events.cart.stock_sold_single }}</strong></p>
					{% endif %}

					{% if events.cart.no_stock %}
						<p>Existem produtos que não têm stock suficiente</p>
					{% endif %}

				{% else %}

					{% if events.cart.added %}
						<p>O produto <strong>{{ events.cart.added }}</strong> foi adicionado ao carrinho.</p>
						{% set button_label = 'Continuar a comprar' %}
					{% elseif events.cart.error %}
						<p>O produto não foi adicionado ao carrinho.</p>
						{% set button_label = 'Continuar a comprar' %}
					{% elseif events.cart.updated %}
						<p>O carrinho de compras foi actualizado</p>
					{% elseif events.cart.session_updated_items or events.cart.session_not_updated_items or events.cart.session_updated %}
						<p>O carrinho de compras foi actualizado</p>
						{% if events.cart.session_updated_items %}
							<p><strong>Produtos adicionados</strong></p>
							<ul>
								{% for product in events.cart.session_updated_items %}
									<li><strong>{{ product.qty }}x</strong> - {{ product.title }}</li>
								{% endfor %}
							</ul>
						{% endif %}
						{% if events.cart.session_not_updated_items %}
							<p><strong>Produtos não adicionados</strong></p>
							<ul>
								{% for product in events.cart.session_not_updated_items %}
									<li><strong>{{ product.qty }}x</strong> - {{ product.title }}</li>
								{% endfor %}
							</ul>
						{% endif %}
					{% elseif events.cart.deleted %}
						<p>O produto foi removido do carrinho.</p>
					{% endif %}

				{% endif %}
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">{{ button_label }}</a>
				{% if events.cart.added %}
					<a class="btn btn-inverse" href="{{ site_url('cart') }}"><i class="fa fa-shopping-cart fa fa-white"></i> Ver Carrinho</a>
				{% endif %}
			</div>
		</div>
	{% endif %}

	{% if events.newsletter_error or events.newsletter_status_success or events.newsletter_status_error or events.newsletter_removal %}
		<div class="modal hide fade modal-alert">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Newsletter</h3>
			</div>
			<div class="modal-body">
				{% if events.newsletter_error %}
					<h5>Não foi possível efectuar o registo na newsletter:</h5>
					<p>{{ events.newsletter_error }}</p>
				{% endif %}

				{% if events.newsletter_status_success %}
					<p>O seu e-mail foi inscrito com sucesso.</p>
				{% endif %}

				{% if events.newsletter_status_error %}
					<p>O seu e-mail já se encontra inscrito na nossa newsletter.</p>
				{% endif %}

				{% if events.newsletter_removal %}
					<p>{{ events.newsletter_removal }}</p>
				{% endif %}
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Fechar</a>
			</div>
		</div>
	{% endif %}

	{% if events.paypal_success %}
		<div class="modal hide fade modal-alert">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Paypal</h3>
			</div>
			<div class="modal-body">
				<p>O pagamento Paypal foi registado e processado com sucesso.</p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Fechar</a>
			</div>
		</div>
	{% endif %}

	{% if events.contact_form_success or events.contact_form_errors %}
		<div class="modal hide fade modal-alert">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Formulário de Contacto</h3>
			</div>
			<div class="modal-body">
				{% if events.contact_form_success %}
					<p>A sua mensagem foi enviada com sucesso. Obrigado pelo contacto.</p>
				{% endif %}

				{% if events.contact_form_errors %}
					<p>Não foi possivel enviar a sua mensagem:</p>
					<p>{{ events.contact_form_errors }}</p>
				{% endif %}
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Fechar</a>
			</div>
		</div>
	{% endif %}

	{% if apps.google_translate %}
		<div class="modal hide fade" id="modal-language" role="dialog" aria-labelledby="modal-languageLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="modal-languageLabel">Language</h3>
			</div>
			<div class="modal-body">
				<div id="google_translate_element"></div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			</div>
		</div>
	{% endif %}

	<!--[if lt IE 8]>
	<div class="modal hide fade modal-alert">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>Actualize o seu browser</h3>
		</div>
		<div class="modal-body">
			<p class="chromeframe">Está a usar um browser (navegador) desactualizado.<br><a href="http://browsehappy.com/" target="_blank">Actualize o seu browser</a> ou instale o  <a href="http://www.google.com/chromeframe/?redirect=true" target="_blank">Google Chrome Frame</a> para ter uma melhor e mais segura experiência de navegação.</p>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">Fechar</a>
		</div>
	</div>
	<![endif]-->

	<div id="fb-root"></div>

	<script>
		/* Facebook JS SDK */
		window.fbAsyncInit = function() {
			FB.init({
				appId : {{ apps.facebook_login.app_id|default(267439666615965) }},
				autoLogAppEvents : true,
				cookie: true,
				xfbml : true,
				version : 'v2.11'
			});
			$('.shopkit-auth-btn-facebook').attr('disabled', false).removeClass('disabled');
		};
		(function(d, s, id){
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {return;}
			js = d.createElement(s); js.id = id;
			js.src = "https://connect.facebook.net/pt_PT/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
		/* End Facebook JS SDK */

		{% if not apps.google_analytics_ec %}
			/* Google Analytics */
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-28055653-2']);
			_gaq.push(['_setDomainName', '{{ domain }}']);
			_gaq.push(['_trackPageview']);

			{% if apps.google_analytics %}
				_gaq.push(['b._setAccount', '{{ apps.google_analytics.tracking_id }}']);
				_gaq.push(['b._trackPageview']);
			{% endif %}

			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
			/* End Google Analytics */
		{% endif %}

		Modernizr.load([
			{% if apps.google_translate %} ,{load: '//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit'}{% endif %}
		]);

		{% if apps.google_translate %}
			function googleTranslateElementInit()
			{
				new google.translate.TranslateElement({pageLanguage: 'pt', includedLanguages: '{{ apps.google_translate.languages }}', gaTrack: true, gaId: 'UA-28055653-2'}, 'google_translate_element');
			}
		{% endif %}

		{% if store.custom_js %}
			{{ store.custom_js }}
		{% endif %}
	</script>

	<script src="{{ store.assets.plugins }}"></script>
	<script src="{{ store.assets.scripts }}"></script>

	{{ footer_content }}

</body>
</html>