#! /bin/bash
hugo --minify
git add .
git commit -m '自动提交'
git push -f origin master
cmd /k
