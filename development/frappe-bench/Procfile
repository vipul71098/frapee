
web: bench serve --port 8000

socketio: /home/frappe/.nvm/versions/node/v14.18.1/bin/node apps/frappe/socketio.js

watch: bench watch

schedule: bench schedule
worker_short: bench worker --queue short 1>> logs/worker.log 2>> logs/worker.error.log
worker_long: bench worker --queue long 1>> logs/worker.log 2>> logs/worker.error.log
worker_default: bench worker --queue default 1>> logs/worker.log 2>> logs/worker.error.log

