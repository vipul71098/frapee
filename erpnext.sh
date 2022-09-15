#!/bin/bash
BENCH_NAME='erpnext-testing.localhost'
git clone https://github.com/frappe/frappe_docker.git
cd frappe_docker
cp -R devcontainer-example .devcontainer
docker-compose -f .devcontainer/docker-compose.yml up -d
docker exec -e "TERM=xterm-256color" -w /workspace/development -it devcontainer_frappe_1 /bin/sh -c "
bench init --skip-redis-config-generation --frappe-branch version-14 --python python3.10 frappe-bench;
cd frappe-bench
bench set-config -g db_host mariadb;
bench set-config -g redis_cache redis://redis-cache:6379;
bench set-config -g redis_queue redis://redis-queue:6379;
bench set-config -g redis_socketio redis://redis-socketio:6379;
bench new-site $BENCH_NAME --mariadb-root-password 123 --admin-password admin --no-mariadb-socket;
bench --site $BENCH_NAME set-config developer_mode 1;
bench --site $BENCH_NAME clear-cache;
bench --site $BENCH_NAME enable-scheduler;
bench get-app --branch version-14 erpnext;
bench --site $BENCH_NAME install-app erpnext;
bench get-app payments;
bench get-app hrms;
bench --site $BENCH_NAME install-app hrms;
cd sites
echo "${BENCH_NAME}" > currentsite.txt;
bench start;
"
# bench get-app payments;
# bench get-app hrms;
# bench --site $BENCH_NAME install-app hrms;