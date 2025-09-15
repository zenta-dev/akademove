.PHONY: gen-oapi-mobile gen-oapi-web gen

gen-oapi-mobile:
	openapi-generator-cli generate -i https://akademove-server.zenta.dev/openapi.json -o gen/dart/api_client -g dart-dio --additional-properties=pubName=api_client
	openapi-generator-cli generate -i auth-oapi.json -o gen/dart/auth_client -g dart-dio --additional-properties=pubName=auth_client

gen-oapi-web:
	cd apps/web && bun openapi-ts

gen: 
	$(MAKE) gen-oapi-mobile
	$(MAKE) gen-oapi-web
