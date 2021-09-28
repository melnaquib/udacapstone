NAME = amsalama/udacitycapstone
PNAME = amsalama/udacitycapstone
VERSION = 1.0.0
Dockerfile=Dockerfile

all: build

build:
	docker build -f ${Dockerfile}  -t $(NAME) .
	docker tag $(NAME) $(NAME):$(VERSION)

push:
	docker push $(NAME)

ppush: build
	docker tag $(NAME) $(PNAME)
	docker tag $(NAME) $(PNAME):$(VERSION)
	docker push $(PNAME)

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	hadolint Dockerfilegreen
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	#pylint --disable=R,C,W1203 app.py

all: install lint test
