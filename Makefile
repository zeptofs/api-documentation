.DEFAULT_GOAL := help

.PHONY: help
help: ## Prints available commands
	@# Use `##` to denote command descriptions (eg previous line)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Starts the application locally
	bundle install
	yarn install
	open http://localhost:4567
	bundle exec foreman start

.PHONY: publish
publish: ## Publishes changes directly to Github Pages
	./deploy.sh
