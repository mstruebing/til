server:
	mix phx.server

reset:
	mix ecto.reset

clean-server: reset server

start-db:
	docker-compose up

.PHONY: db
db:
	docker-compose exec postgresql 'psql --user postgres til_dev'
