# Devel stack to test Cortex
This is a simple Docker compose stack.

It embeds:
- `Grafana` has data sources configured in [grafana/datasources](grafana/datasources)
- `prometheus` generates data from itself
- `cortex` starts with 3 instances
- `consul` single-node to make cortex instances work as a cluster
- `nginx` to act as load balancer for both Prom & Grafana

# Usage
Ensure your docker engine is running and that you have make.
Makefile developed with Apple's GNU make. However it should be portable.

Start the stack with `make start`, and visit Grafana at http://localhost:3000 (user is "admin:admin")
By default 3 `cortex` instances are spawned.

Scale cortex instances: `docker-compose up -d --scale cortex=1`

If you want to restart a single component use `make restart <component>`.
For example: `make restart lb`

Stop the stack with `make stop`

# TODO
- If DB is centralized, are shards distributed or all µservice reads the same data?

# Results
- HA is easy, stateless [except for ingesters](https://github.com/cortexproject/cortex/blob/master/docs/architecture.md)
- Specialization of µservices is done by the lb, no config.
- Short outages is [managed by Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) (retry, backoff, buffer size, etc.). /!\ Seems legit but impossible to theorize. Very empirical /!\
