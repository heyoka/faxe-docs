.PHONY: build

build:
	mkdocs build && \
	redoc-cli bundle rest-api/swagger_faxe.yaml && \
	mv redoc-static.html site/faxe_rest_api.html && \
	cp docs/images/favicon.png site/assets/images/favicon.png