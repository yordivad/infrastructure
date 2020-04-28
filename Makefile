.PHONY: all clean build test deploy deploy-dev debug staging-deploy dependencies set-local set-prod

KUBECONFIG=$KUBECONFIG:./dist/prod.config:./dist/dev.config

all: clean build

clean:
	./scripts/clean.sh

build:
	./scripts/build.sh

test:
	./scripts/test.sh

debug:
	./scripts/deploy.sh -e dev -d true

deploy-dev:
	./scripts/deploy.sh -e dev

deploy-sta:
	./scripts/clean.sh
	./scripts/cluster_setup.sh -d
	./scripts/deploy.sh -e sta

deploy:
	./scripts/clean.sh
	./scripts/cluster_setup.sh -p
	./scripts/deploy.sh -e pro

docker:
	./scripts/docker.sh

dependencies:
	./scripts/dependencies.sh

set-local:
	./scripts/context.sh -l

set-prod:
	./scripts/context.sh -p