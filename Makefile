.PHONY: all clean build test deploy deploy-dev debug staging-deploy dependencies

all: clean build

clean:
	./scripts/clean.sh

build:
	./scripts/build.sh

test:
	./scripts/test.sh

debug:
	./scripts/deploy.sh -e dev -d true

dev-deploy:
	./scripts/deploy.sh -e dev

staging-deploy:
	./scripts/deploy.sh -e sta

deploy:
	./scripts/deploy.sh -e pro

docker:
	./scripts/docker.sh

dependencies:
	./scripts/dependencies.sh
