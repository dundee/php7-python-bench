SHELL = /usr/bin/bash
COUNT=100

DIR=~/work/php7-python-bench

test:
	@for i in {1..30}; do bash -c "ab -c 10 -n $(COUNT) http://127.0.0.1:9000/?n=$$i 2>/dev/null | grep 'Requests per second' | tr -s ' ' | cut -d' ' -f4"; done

nette:
	cd nette && ./composer.phar install
	php-fpm -F -O -p . -y ./nette-php-fpm.conf &
	nginx -c $(DIR)/nette-nginx.conf

slim:
	cd slim && ./composer.phar install
	php-fpm -F -O -p . -y ./slim-php-fpm.conf &
	nginx -c $(DIR)/slim-nginx.conf

flask:
	cd flask && python -m venv venv
	cd flask && rm *.so
	cd flask && ./venv/bin/pip install -r requirements.txt
	cd flask && uwsgi --ini ../flask-uwsgi.ini -H ./venv -s ../uwsgi.sock &
	nginx -c $(DIR)/flask-nginx.conf

flask-pypy:
	cd flask && sudo pypy -m pip install -r requirements.txt
	cd flask && uwsgi --ini ../flask-pypy-uwsgi.ini --pypy-home /opt/pypy -s ../uwsgi.sock &
	nginx -c $(DIR)/flask-nginx.conf

flask-cython:
	cd flask && python -m venv venv
	cd flask && ./venv/bin/pip install -r requirements.txt
	cd flask && cythonize -b fib.pyx
	cd flask && uwsgi --ini ../flask-uwsgi.ini -H ./venv -s ../uwsgi.sock &
	nginx -c $(DIR)/flask-nginx.conf

.PHONY: nette slim flask
