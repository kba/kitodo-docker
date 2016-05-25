.PHONY: all run-%

PORT_PRODUCTION = 10102

images = production database

all: production database
	docker run --detach=true --name kitodo-database kitodo/database || true
	docker run -it --rm -p $(PORT_PRODUCTION):8080 --name kitodo-production --link kitodo-database:mysql kitodo/production

run-%: %
	docker run --rm -p $(PORT_PRODUCTION):8080 -it "kitodo/$^"

$(images): % :  docker/%
	docker build -t 'kitodo/$@' $<
