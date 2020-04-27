.PHONY: all clean build deploy deploy-dev debug staging-deploy

all: clean build

clean:
	./scripts/clean.sh

build:
	./scripts/build.sh

debug:
	./scripts/deploy.sh -e dev -d true

dev-deploy:
	./scripts/deploy.sh -e dev

staging-deploy:
	./scripts/deploy.sh -e sta

deploy:
	./scripts/deploy.sh -e pro
