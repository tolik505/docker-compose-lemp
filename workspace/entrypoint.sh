#!/bin/bash

exec /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
exec supervisorctl start laravel-queue-listen:*
