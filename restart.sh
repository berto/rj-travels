#!/bin/bash
lsof -i :8888 | awk '{print $2}' | sed -n '1!p' | xargs kill
rvm use ruby-2.4.0
rails s -p 8888 -d --environment=production
