fillgf:
	@sleep 1
	@for i in grafana/datasources/*; do \
	curl -sX POST localhost:3000/api/datasources \
	-H "Content-Type: application/json" -u admin:admin -d @$$i > /dev/null \
	&& echo "$$i added"; done;

kill:
	# Cannot filter-out with $@ because it may be invoked through the restart target.
	docker-compose rm -sf $(filter-out kill restart, ${MAKECMDGOALS})

restart: kill start

start: up fillgf

stop:
	@docker-compose down
up:
	@docker-compose up -d --scale cortex=3
%:
	@:
