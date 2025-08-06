build:
	packer init .
	packer build -var "version=${KLUCTL_VERSION}" .

login:
	echo '${DOCKER_TOKEN}' | docker login --username akester --password-stdin

push-remote: login
	docker push akester/kluctl:latest
	docker push "akester/kluctl:${KLUCTL_VERSION}"
