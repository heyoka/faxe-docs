.PHONY: build

build:
	mkdocs build && \
	npx @redocly/cli build-docs rest-api/swagger_faxe.yaml --output redoc-static.html && \
	mv redoc-static.html site/faxe_rest_api.html && \
	cp docs/images/favicon.png site/assets/images/favicon.png