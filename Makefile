.PHONY: composer run
default: run


composer:
	docker run --rm -v `pwd`:/app composer install

run: req-site
	docker build -t site-diff .
	docker run --rm -v `pwd`/output:/app/output site-diff ${A} ${B}


req-site:
ifndef A
	$(error The variable `A` needs to be set to a url)
endif
ifndef B
	$(error The variable `B` needs to be set to a url)
endif