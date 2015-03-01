#!/bin/bash

if [ $# -ne 1 ]; then
    echo "argument error"
    exit 1
fi

APP_ROOT=${EOPES_ROOT}

bundle exec rails runner "Jobs::IndustrySystemCrawler.new.run" -e $1

exit 0