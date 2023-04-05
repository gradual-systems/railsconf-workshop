
set -e

echo "\n\n\n################################################################################"
echo "################################################################################"
echo "################################################################################"
echo "\nSCRIPT 01: Extracting an admin package within the mastodon app"
read -n 1 -p "Press any key to continue"
echo ""





echo "\n\n\nRunning some tests against a PRISTINE version of MASTODON"
read -n 1 -p "Press any key to continue"
echo ""

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features





echo "\n\n\nMoving admin code (identified by anything in a app/*/admin folder) into a pack and running tests"
read -n 1 -p "Press any key to continue"
echo ""

gsed '/use_packs/d' Gemfile

echo "\n\n\n
gem 'use_packs'
" >> Gemfile

bundle

bundle binstubs bundler --force
bundle binstub use_packs
bundle binstub packwerk

bin/packwerk init

# Exluding a file that doesn't sit well with packwerk
gsed -i 's/# exclude\:/exclude\:/' packwerk.yml
gsed -i '/exclude\:/a- lib\/templates\/rails\/post_deployment_migration\/migration.rb' packwerk.yml

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

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features || echo "\n\n\nSpec execution failed because packs directory is being ignored by Rails"





echo "\n\n\nInstalling packs-rails to make Rails pick up the packs directory"
read -n 1 -p "Press any key to continue"
echo ""

echo "\n\n\n
gem 'packs-rails'
" >> Gemfile

bundle

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features





echo "\n\n\nTESTS PASS!!! Let's see what packwerk says"
read -n 1 -p "Press any key to continue"
echo ""

bin/packwerk update





echo "\n\n\nCheck out package_todo.yml and packs/admin/package_todo.yml"
echo " Not many violations in the root, YIKES!! Lots of violations in the admin... which is expected"
read -n 1 -p "Press any key to continue"
echo ""

open package_todo.yml
open packs/admin/package_todo.yml





echo "\n\n\nLet's accept that the admin package depends on the root package"
read -n 1 -p "Press any key to continue"
echo ""

echo "
dependencies:
- .
" >> packs/admin/package.yml

bin/packwerk update





echo "\n\n\nLet's take a closer look at the root package_todo.yml"
read -n 1 -p "Press any key to continue"
echo ""

open package_todo.yml

echo "\n\n\nThere is a bunch of admin code still in the root pack (In those API folders)"
read -n 1 -p "Press any key to continue"
echo ""





echo "\n\n\nMove the API admin code into the admin package and update package todos"
read -n 1 -p "Press any key to continue"
echo ""

bin/packs move packs/admin \
  app/controllers/api/v1/admin \
  app/controllers/api/v2/admin \

bin/packwerk update

open package_todo.yml





echo "\n\n\nLet's see if can't move the remaining violation causing files into the root app..."
read -n 1 -p "Press any key to continue"
echo ""

bin/packs move . \
  packs/admin/app/workers/admin/account_deletion_worker.rb \
  packs/admin/app/models/admin/action_log.rb \
  packs/admin/app/models/admin/import.rb \
  packs/admin/app/workers/admin/suspension_worker.rb \
  packs/admin/app/workers/admin/unsuspension_worker.rb

bin/packwerk update

echo "If there are no more package_todo.yml files, we're good"

find . -iname "package_todo.yml"