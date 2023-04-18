set -x
set -e

git checkout main
git clean -fd
git checkout .

../mastodon-workshop/00.sh

git branch -D 01 || echo "branch doesn't exist"
git branch -D 02 || echo "branch doesn't exist"
git branch -D 03 || echo "branch doesn't exist"
git branch -D 04 || echo "branch doesn't exist"
git branch -D 05 || echo "branch doesn't exist"
git branch -D 06 || echo "branch doesn't exist"

../mastodon-workshop/01.sh && git checkout -b 01 && git add . && git commit -n -m "01"
../mastodon-workshop/02.sh && git checkout -b 02 && git add . && git commit -n -m "02"
../mastodon-workshop/03.sh && git checkout -b 03 && git add . && git commit -n -m "03"
../mastodon-workshop/04.sh && git checkout -b 04 && git add . && git commit -n -m "04"
../mastodon-workshop/05.sh && git checkout -b 05 && git add . && git commit -n -m "05"
../mastodon-workshop/06.sh && git checkout -b 06 && git add . && git commit -n -m "06"