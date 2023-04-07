
set -e

puts_h1 () {
    echo "  \n\n\n################################################################################"
    echo "### " $1
    echo "################################################################################"
    echo ""
}

puts_h2 () {
    puts ""
    echo $1 | sed -e 's/^/*** /'
}

puts () {
  echo $1 | sed -e 's/^/    /'
}

if [ "$1" = "ni" ]; then
    interactive=false
else
    interactive=true
fi

$interactive || echo "Script in non-interactive mode"
$interactive && echo "Script in interactive mode"





puts_h1 "SCRIPT 02: Move all code into a user faching app package"
puts ""

bin/packs create packs/user_facing_app

bin/packs move packs/user_facing_app app

gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/helpers/branding_helper.rb
gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/validators/reaction_validator.rb

gsed -i 's/- \./- packs\/user_facing_app/' packs/admin/package.yml
echo "
dependencies:
- packs/user_facing_app
" >> package.yml

bin/packwerk update

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features






puts_h2 "If there are no more package_todo.yml files, we're good"

find . -iname "package_todo.yml"