#!/usr/bin/env bash

bin/magento setup:install --backend-frontname=backend \
     	--amqp-host="${RABBIT_HOST}" \
     	--amqp-port="${RABBIT_PORT}" \
     	--amqp-user="${RABBIT_USER}" \
     	--amqp-password="${RABBIT_PASS}" \
     	--db-host="${DB_HOST}" \
     	--db-name="${DB_PATH}" \
     	--db-user="${DB_USER}" \
     	--db-password="${DB_PASS}" \
     	--search-engine="${SEARCH_REL}" \
     	--opensearch-host="${SEARCH_HOST}" \
     	--opensearch-port="${SEARCH_PORT}" \
     	--opensearch-index-prefix=magento2 \
     	--opensearch-enable-auth=0 \
     	--opensearch-timeout=15 \
     	--http-cache-hosts=varnish:80 \
     	--session-save=redis \
     	--session-save-redis-host="${REDIS_HOST}" \
     	--session-save-redis-port="${REDIS_PORT}" \
     	--session-save-redis-db=2   \
     	--session-save-redis-max-concurrency=20 \
     	--cache-backend=redis \
     	--cache-backend-redis-server="${REDIS_HOST}" \
     	--cache-backend-redis-db=0 \
     	--cache-backend-redis-port="${REDIS_PORT}" \
     	--page-cache=redis \
     	--page-cache-redis-server="${REDIS_HOST}" \
     	--page-cache-redis-db=1 \
     	--page-cache-redis-port="${REDIS_PORT}"


bin/magento config:set --lock-env web/unsecure/base_url "${MAGENTO_ROUTE}"
bin/magento config:set --lock-env web/secure/base_url "${MAGENTO_ROUTE}"
bin/magento config:set --lock-env web/secure/offloader_header X-Forwarded-Proto
bin/magento config:set --lock-env web/secure/use_in_frontend 1
bin/magento config:set --lock-env web/secure/use_in_adminhtml 1
bin/magento config:set --lock-env web/seo/use_rewrites 1
bin/magento config:set --lock-env system/full_page_cache/caching_application 2
bin/magento config:set --lock-env system/full_page_cache/ttl 604800
bin/magento config:set --lock-env dev/static/sign 0
bin/magento cache:disable block_html
bin/magento cache:flush
