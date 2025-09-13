#!/bin/bash -x
find . -type d -exec chmod 0700 -f {} +
find . -type f -exec chmod 0600 -f {} +