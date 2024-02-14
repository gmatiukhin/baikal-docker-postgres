build: apache nginx

apache:
	docker buildx build -f ./apache.dockerfile --platform linux/arm64,linux/amd64,linux/386 . --tag registry.gmatiukhin.site/baikal:0.9.3-apache-pgsql --push

nginx:
	docker buildx build -f ./nginx.dockerfile --platform linux/arm64,linux/amd64,linux/386 . --tag registry.gmatiukhin.site/baikal:0.9.3-nginx-pgsql --push
