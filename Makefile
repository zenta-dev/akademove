.PHONY: gen-oapi-mobile gen

gen-oapi-mobile:
	openapi-generator-cli generate -i https://akademove-server.zenta.dev/api/spec.json -o gen/dart/api_client -g dart-dio --additional-properties=pubName=api_client
	openapi-generator-cli generate -i auth-oapi.json -o gen/dart/auth_client -g dart-dio --additional-properties=pubName=auth_client

gen: 
	$(MAKE) gen-oapi-mobile 
