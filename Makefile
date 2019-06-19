.PHONY: environment
environment:
	@pyenv -s install 3.5.6
	@pyenv virtualenv 3.5.6 mockutil
	@pyenv local mockutil

.PHONY: tests
tests:
	@python -m pytest -n=auto --cov-config=.coveragerc --cov=mockutil --cov-report term --cov-report html:htmlcov --cov-report xml:coverage.xml tests
	@python -m coverage xml -i

.PHONY: unit-tests
unit-tests:
	@echo ""
	@echo "Unit Tests"
	@echo "=========="
	@echo ""
	@COV_CORE_DATAFILE=.unit.coverage python -m pytest -n auto --cov-config=.coveragerc --cov-report term --cov-report xml:unit-tests-cov.xml --cov=mockutil --cov-fail-under=75 tests/unit

.PHONY: integration-tests
integration-tests:
	@echo ""
	@echo "Integration Tests"
	@echo "================="
	@echo ""
	@COV_CORE_DATAFILE=.integration.coverage python -m pytest -n auto --cov-config=.coveragerc --cov-report term --cov-report xml:integration-tests-cov.xml --cov=mockutil --cov-fail-under=60 tests/integration

.PHONY: style-check
style-check:
	@echo ""
	@echo "Code Style"
	@echo "=========="
	@echo ""
	@python -m black --check -t py36 --exclude="build/|buck-out/|dist/|_build/|pip/|\.pip/|\.git/|\.hg/|\.mypy_cache/|\.tox/|\.venv/" . && echo "\n\nSuccess" || echo "\n\nFailure\n\nRun \"make black\" to apply style formatting to your code"
	@echo ""

.PHONY: check-flake8
check-flake8:
	@echo ""
	@echo "Flake 8"
	@echo "======="
	@echo ""
	@python -m flake8 && echo "Success"
	@echo ""

.PHONY: black
black:
	@python -m black -t py36 --exclude="build/|buck-out/|dist/|_build/|pip/|\.pip/|\.git/|\.hg/|\.mypy_cache/|\.tox/|\.venv/" .

.PHONY: package
package:
	@PYTHONPATH=. python -m setup sdist bdist_wheel

.PHONY: install
install:
	@PYTHONPATH=. python -m pip install -U -r requirements.txt -U -r requirements.dev.txt

.PHONY: required_install
required_install:
	@PYTHONPATH=. python -m pip install -U -r requirements.txt

