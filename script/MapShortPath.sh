#!/bin/bash

if [ $# -ne 2 ]; then
    echo "argument error"
    exit 1
fi

APP_ROOT=${EOPES_ROOT}

cd ${APP_ROOT}/lib
ruby ${APP_ROOT}/lib/extconf.rb
make
bundle exec rails runner "Jobs::MapShortPath.new.run('${APP_ROOT}/tmp/$1')" -e $2

exit 0
