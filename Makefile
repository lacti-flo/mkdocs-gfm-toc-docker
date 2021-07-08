NAME=lacti/mkdocs-gfm-toc

all: build push
	# All done

build: update-nodejs
	docker build -t $(NAME) .

push:
	docker push $(NAME)

update-nodejs:
	curl https://deb.nodesource.com/setup_14.x -o nodejs-14-setup.sh

