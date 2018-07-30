{#
Description: Contact Page
#}

{% extends 'base.tpl' %}

{% block content %}

	{% if store.latitude and store.longitude %}
		<iframe width="100%" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/?q={{ store.latitude }},{{ store.longitude }}&amp;ie=UTF8&amp;t=m&amp;z=12&amp;output=embed"></iframe>
	{% endif %}

	<section class="content">

		<h1>{{ store.page.contact.title }}</h1>
		<br>

		<div class="row-fluid">
			<div class="span5">
				<h4>{{ store.name }}</h4>
				<br>

				{% if store.show_email %}
					<h5>E-mail</h5>
					<p>{{ safe_mailto(store.email) }}</p>
					<br>
				{% endif %}

				{% if store.phone %}
					<h5>Telefone</h5>
					<p>{{ store.phone }}</p><br>
				{% endif %}

				{% if store.cellphone %}
					<h5>Telemóvel</h5>
					<p>{{ store.cellphone }}</p><br>
				{% endif %}

				{% if store.address %}
					<h5>Morada</h5>
					<p>{{ store.address|nl2br }}</p>
				{% endif %}
			</div>

			<div class="span5">
				<h4 class="margin-bottom">Formulário de Contacto</h4>

				{{ form_open('contact_form', 'class="contact-form" id="contact-form"') }}

					<label for="name">Nome <small class="muted">(*)</small></label>
					<input type="text" name="name" id="name" class="input-block-level" placeholder="O seu nome" value="{{ store.page.contact.form.name|default(user.name) }}" required>

					<label for="email">E-mail <small class="muted">(*)</small></label>
					<input type="email" name="email" id="email" class="input-block-level" placeholder="Endereço de e-mail" value="{{ store.page.contact.form.email|default(user.email) }}" required>

					<label for="subject">Assunto <small class="muted">(*)</small></label>
					<input type="text" name="subject" id="subject" class="input-block-level" placeholder="Assunto do contacto" value="{{ store.page.contact.form.subject|default(get.p) }}" required>

					<label for="message">Mensagem <small class="muted">(*)</small></label>
					<textarea rows="6" class="input-block-level" id="message" name="message" required>{% if not events.contact_form_success %}{{ get.p ? "Desejo receber mais informações sobre #{get.p}" }}{% endif %}</textarea>

					<div class="g-recaptcha margin-bottom-xs" data-sitekey="{{ apps.google_recaptcha.sitekey }}"></div>

					<button type="submit" class="button">Enviar Mensagem</button>

				{{ form_close() }}
			</div>
		</div>

		<hr>

		{{ store.page.contact.content }}

	</section>

{% endblock %}