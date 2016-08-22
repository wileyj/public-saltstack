#!/bin/bash
set -e
service celerybeat stop
service celeryd restart
service celerybeat start
