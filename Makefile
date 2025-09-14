API_REMOTE_OAPI_JSON = https://akademove-server.zenta.dev/openapi.json
AUTH_LOCAL_OAPI      = auth-oapi.json

.PHONY: gen-oapi-mobile gen-oapi-web gen

gen-oapi-mobile:
	openapi-generator-cli generate -i $(API_REMOTE_OAPI_JSON) -o gen/dart/api_client -g dart-dio --additional-properties=pubName=api_client
	openapi-generator-cli generate -i $(AUTH_LOCAL_OAPI) -o gen/dart/auth_client -g dart-dio --additional-properties=pubName=auth_client

gen-oapi-web:
	openapi-generator-cli generate -i $(API_REMOTE_OAPI_JSON) -o gen/ts/api-client/src -g typescript-fetch

gen: 
	$(MAKE) gen-oapi-mobile
	$(MAKE) gen-oapi-web
