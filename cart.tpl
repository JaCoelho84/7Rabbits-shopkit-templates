{#
Description: Shopping cart page
#}

{% extends 'base.tpl' %}

{% block content %}

	<section class="content">

		<p class="breadcrumbs">
			<a href="/"><i class="fa fa-home"></i></a> ›
			Carrinho de Compras
		</p>
		<br>

		<h1>Carrinho de Compras</h1>
		<br>

		{% if events.cart.session_updated %}
			<div class="alert">
				<h5>Aviso</h5>
				<p>O carrinho de compras foi actualizado:</p>
				<ul>
					{% for key in events.cart.session_updated %}
						<li><strong>{{ key.title }}</strong> ({{ key.message }})</li>
					{% endfor %}
				</ul>
			</div>
		{% endif %}

		{% if cart.items %}

			{% if events.cart.no_stock %}
				<div class="alert">
					<h5>Aviso</h5>
					<p>Os seguintes produtos não foram atualizados por falta de stock:</p>
					<ul>
						{% for key in events.cart.no_stock %}
							<li>{{ cart.items[key].title }}</li>
						{% endfor %}
					</ul>
				</div>
			{% endif %}

			{{ form_open('cart/update') }}
				<div class="table-responsive">
					<table class="table table-bordered table-cart">
						<thead>
							<tr>
								<th>Produto</th>
								<th>Quantidade</th>
								<th style="text-align:right;">Subtotal</th>
								<th style="text-align:center;">Remover</th>
							</tr>
						</thead>
						<tbody>
						{% for item in cart.items %}
							<tr data-product="{{ item.product_id }}" data-product-option="{{ item.options|keys[0] }}">
								<td>{{ item.title }}</td>
								<td><div class="form-inline"><input class="input-mini" type="number" value="{{ item.qty }}" name="qtd[{{ item.item_id }}]" {% if item.stock_sold_single %} data-toggle="tooltip" data-placement="bottom" data-original-title="Só é possível comprar 1 unidade deste produto." title="Só é possível comprar 1 unidade deste produto." readonly {% endif %}> <button type="submit" class="button btn-small"><i class="fa fa-refresh"></i><span class="visible-desktop">&nbsp;&nbsp;Alterar</span></button></div></td>
								<td class="price text-right">{{ item.subtotal | money_with_sign }}</td>
								<td class="text-center"><a href="{{ item.remove_link }}" class="button btn-small"><i class="fa fa-trash"></i><span class="visible-desktop">&nbsp;&nbsp;Remover</span></a></td>
							</tr>
						{% endfor %}
						</tbody>
						<tfoot>
							<tr>
								<td class="subtotal">Subtotal Encomenda</td>
								<td colspan="2" class="subtotal price text-right">{{ cart.subtotal | money_with_sign }}</td>
								<td class="subtotal">&nbsp;</td>
							</tr>
						</tfoot>
					</table>
				</div>

				<p><a class="button" href="{{ site_url('cart/data') }}">Prosseguir &nbsp; <i class="fa fa-chevron-circle-right"></i></a></p>

			{{ form_close() }}

		{% else %}

			<p>Não existem produtos no carrinho.</p>

		{% endif %}

	</section>

{% endblock %}