#!/bin/bash

# github pages가 바라보는 gh-pages 브랜치를 만든다.
git checkout master

# 최신 gh-pages 브랜치 정보를 가져와 rebase를 진행한다.
git pull origin master --rebase

rm -rf docs
mkdir docs
# gitbook 의존 파일을 설치하고 gitbook 빌드를 돌린다.
gitbook install && gitbook build

# gitbook build로 생긴 _book폴더 아래 모든 정보를 현재 위치로 가져온다.
cp -R _book/* ./docs

# node_modules폴더와 _book폴더를 지워준다.
git clean -fx node_modules
git clean -fx _book

rm ./docs/publish.sh

# NOQA
git add .

# 커밋커밋!
git commit -a -m "Update docs"

# gh-pages 브랜치에 PUSH!
git push origin master
