setup: install db-prepare

install:
	bundle install

db-prepare:
	bin/rails db:reset

start:
	rm -rf tmp/pids/server.pid
	bin/rails s

lint:
	bundle exec rubocop
# 	bundle exec slim-lint app/views/

test:
	bin/rails test

.PHONY: test
