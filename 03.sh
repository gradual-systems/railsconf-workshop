
set -e

echo "Create pack for 'messy middle'"

bin/packs create packs/messy_middle

bin/packs move packs/messy_middle \
  packs/admin/app/workers/admin/account_deletion_worker.rb \
  packs/admin/app/models/admin/action_log.rb \
  packs/admin/app/models/admin/import.rb \
  packs/admin/app/workers/admin/suspension_worker.rb \
  packs/admin/app/workers/admin/unsuspension_worker.rb

bin/packwerk update

bin/packs visualize
cp packwerk.png ../03.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../03_package_todo.yml
