SHELL = /usr/bin/bash
COUNT=10000

DIR=~/workspace/php7-python-bench

test:
	@for i in {1..100}; do bash -c "ab -c $$i -n $(COUNT) http://127.0.0.1:9000/ 2>/dev/null | grep 'Requests per second' | tr -s ' ' | cut -d' ' -f4"; done

nette:
	cd nette && ./composer.phar install
	php-fpm -F -O -p . -y ./nette-php-fpm.conf &
	nginx -c $(DIR)/nette-nginx.conf

