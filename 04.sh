
set -e

echo "Merge 'messy middle' with root pack"

bin/packs move . \
  packs/messy_middle/app/workers/admin/account_deletion_worker.rb \
  packs/messy_middle/app/models/admin/action_log.rb \
  packs/messy_middle/app/models/admin/import.rb \
  packs/messy_middle/app/workers/admin/suspension_worker.rb \
  packs/messy_middle/app/workers/admin/unsuspension_worker.rb

rm -rf packs/messy_middle

bin/packwerk update

bin/packs visualize
cp packwerk.png ../04.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../04_package_todo.yml



# find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
