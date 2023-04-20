set -x
set -e

git checkout main
git clean -fd
git checkout .

../railsconf-workshop/00.sh

git branch -D 01 || echo "branch doesn't exist"
git branch -D 02 || echo "branch doesn't exist"
git branch -D 03 || echo "branch doesn't exist"
git branch -D 04 || echo "branch doesn't exist"
git branch -D 05 || echo "branch doesn't exist"
git branch -D 06 || echo "branch doesn't exist"

../railsconf-workshop/01.sh && git checkout -b 01 && git add . && git commit -n -m "01"
../railsconf-workshop/02.sh && git checkout -b 02 && git add . && git commit -n -m "02"
../railsconf-workshop/03.sh && git checkout -b 03 && git add . && git commit -n -m "03"
../railsconf-workshop/04.sh && git checkout -b 04 && git add . && git commit -n -m "04"
../railsconf-workshop/05.sh && git checkout -b 05 && git add . && git commit -n -m "05"
../railsconf-workshop/06.sh && git checkout -b 06 && git add . && git commit -n -m "06"