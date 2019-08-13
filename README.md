# Devel stack to test Cortex
This is a simple Docker compose stack.

It embeds:
- `Grafana` has data sources configured in [grafana/datasources]()
- `prometheus` generates data from itself
- `cortex` starts with 3 instances
- `consul` single-node to make cortex instances work as a cluster
- `nginx` to act as load balancer for both Prom & Grafana

# Usage
Start the stack with `make start`, and visit Grafana at http://localhost:3000 (user is "admin:admin")
By default 3 `cortex` instances are spawned.

Scale cortex instances: `docker-compose up -d --scale cortex=1`

If you want to restart a single component use `make restart <component>`.
For example: `make restart lb`

Stop the stack with `make stop`
