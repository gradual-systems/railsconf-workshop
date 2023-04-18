set -x
set -e

git checkout main
git clean -fd
git checkout .

../mastodon-workshop/00_mastodon_setup.sh

git branch -D 01 || echo "branch doesn't exist"
git branch -D 02 || echo "branch doesn't exist"
git branch -D 03 || echo "branch doesn't exist"
git branch -D 04 || echo "branch doesn't exist"
git branch -D 05 || echo "branch doesn't exist"
git branch -D 06 || echo "branch doesn't exist"

../mastodon-workshop/01_create_admin_pack.sh && git checkout -b 01 && git add . && git commit -n -m "01"
../mastodon-workshop/02_fix_admin_package_dependencies.sh && git checkout -b 02 && git add . && git commit -n -m "02"
../mastodon-workshop/03_create_messy_middle_pack.sh && git checkout -b 03 && git add . && git commit -n -m "03"
../mastodon-workshop/04_empty_messy_middle_pack.sh && git checkout -b 04 && git add . && git commit -n -m "04"
../mastodon-workshop/05_create_user_facing_app_pack.sh && git checkout -b 05 && git add . && git commit -n -m "05"
../mastodon-workshop/06_accept_dependencies.sh && git checkout -b 06 && git add . && git commit -n -m "06"