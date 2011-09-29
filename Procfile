coffee: coffee -o lib/nodejs/ -cw lib/nodejs/src/
thin: bundle exec thin start -p 3000 -e dev_mysql
nodejs: node lib/nodejs/app.js
log: tail -f -n 0 log/dev_mysql.log

