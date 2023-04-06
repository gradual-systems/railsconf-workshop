
set -e

if [ "$1" = "ni" ]; then
    interactive=false
else
    interactive=true
fi

$interactive || echo "Script in non-interactive mode"
$interactive && echo "Script in interactive mode"





echo "\n\n\n################################################################################"
echo "################################################################################"
echo "################################################################################"
echo "\nSCRIPT 02: Move all code into a user faching app package"
$interactive && read -n 1 -p "Press any key to continue"
echo ""

bin/packs create packs/user_facing_app

bin/packs move packs/user_facing_app app

gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/helpers/branding_helper.rb
gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/validators/reaction_validator.rb


bin/packwerk update

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features






echo "If there are no more package_todo.yml files, we're good"

find . -iname "package_todo.yml"