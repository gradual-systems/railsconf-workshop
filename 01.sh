set -x
set -e

echo "Create admin pack"

bin/packs create packs/admin

bin/packs move packs/admin \
  app/chewy/admin \
  app/controllers/admin \
  app/helpers/admin \
  app/javascript/admin \
  app/lib/admin \
  app/mailers/admin \
  app/models/admin \
  app/policies/admin \
  app/presenters/admin \
  app/serializers/admin \
  app/services/admin \
  app/validators/admin \
  app/views/admin \
  app/workers/admin

bin/packwerk update

bin/packs visualize
mv packwerk.png ../01.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../01_package_todo.yml



# find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
