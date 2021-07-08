NAME=lacti/mkdocs-gfm-toc

all: build push
	# All done

build:
	docker build -t $(NAME) .

push:
	docker push $(NAME)

