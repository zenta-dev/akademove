.PHONY: gen-oapi-mobile gen

gen-oapi-mobile:
	openapi-generator-cli generate -i http://localhost:3000/api/spec.json -o gen/dart/api_client -g dart-dio --additional-properties=pubName=api_client

gen: 
	$(MAKE) gen-oapi-mobile 
