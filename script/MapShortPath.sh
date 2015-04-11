#!/bin/bash

if [ $# -ne 1 ]; then
    echo "argument error"
    exit 1
fi

APP_ROOT=${EOPES_ROOT}

ruby ${APP_ROOT}/lib/extconf.rb
make
bundle exec rails runner "Jobs::MapShortPath.new.run" -e $1

exit 0