# RailsConf 2023 Workshop: Gradually Modularizing your Monolith with Ruby Packs and Packwerk
Welcome to the gradual modularization workshop! We hope you enjoy it. We created this participant guide to help make sure you make the most of this workshop.

Packs, located at https://github.com/rubyatscale, is an open-source ecosystem for gradual modularization of Ruby and Rails apps.
This ecosystem is built on the idea of packs – libraries of code with minimal boiler-plate that run in the context of the larger Rails app.

# When and Where
Wednesday, April 26, 10:15 AM - 12:15AM EST
204 J (Fl, 4, Bld 2)
https://railsconf2023.sessionize.com/session/452625

## Before the workshop
### Join the [2023 RailsConf slack server](https://join.slack.com/t/2023railsconf/shared_invite/zt-1t1pb9vn7-Evkz5Hputaui6Ht2nWM64g) and our channel

We’ll be working in the #ws-gradually-modularizing-your-monolith-with-ruby-packs-and-packwerk slack channel. 

There we will share code snippets, debug async, and connect you with helpers should you get stuck. Please post here if you need help or have questions!

### Set Up Your Machine
We highly encourage folks to use their own application for this workshop in addition to Mastodon!
We've created a fork of Mastodon that allows the workshop to be conducted without needing to get the application fully working.

```
# Check out the gradual.systems fork of mastodon

cd YOUR_WORKSPACE
git clone --depth=1 https://github.com/gradual-systems/mastodon.git
git clone https://github.com/gradual-systems/railsconf-workshop.git

pushd mastodon
../railsconf-workshop/00.sh
popd
```

Note that your repos will be next to each other on the filesystem:
```
tree . -L 1
.
├── mastodon
└── railsconf-workshop
```

### Sign Up for Office Hours
We’ll be hosting some office hours before, during, and after the conference to help folks with their ruby and rails modularity efforts! Whether that’s setting up gems, using packwerk, designing modular code, or something else, we’re here to help: [Office Hours Signup Sheet](https://docs.google.com/forms/d/e/1FAIpQLSeBxdwgw3KrYsJIzZr5zETrc5v79NiRN1OTKWma3BW0dPe3KA/viewform)

### Join Us for Modularity Lunch
Gusto will be hosting a lunch to chat about Ruby/Rails Modularity on Tuesday! Hope you can make it. Find us at the table with the LEGO poster.

## During the Workshop

### Running the Workshop Code

There are more scripts in the repo, indexed 01, 02, 03, etc. We'll use these throughout the workshop.

Post a message in our slack channel and our helpers will be right there!

## After the Workshop

### Share Your Learnings With Others
Share what you’ve learned in the slack server and join us for general discussion as together we push Rails modularity forward!

### Upstream Fixes and Improvements to [rubyatscale](https://github.com/rubyatscale)
We’d love to discuss and incorporate improvements to make this toolchain more useful for more folks.

### Join the [Ruby/Rails Modularity Slack Server](https://join.slack.com/t/rubymod/shared_invite/zt-1obvvz3m8-jsuwtghE_xOJl7twYckwLg)
This has been a fantastic community gathering space to discuss modularization for Ruby and Rails! All are welcome to join!

# Resources and Links
- [Ruby/Rails Modularity Slack Server](https://join.slack.com/t/rubymod/shared_invite/zt-1obvvz3m8-jsuwtghE_xOJl7twYckwLg)
- [A How-to Guide to Ruby Packs, Gusto’s Gem Ecosystem for Modularizing Ruby Applications](https://medium.com/gusto-engineering/a-how-to-guide-to-ruby-packs-gustos-gem-ecosystem-for-modularizing-ruby-applications-e236126b8c2c)
- https://github.com/rubyatscale
- [Workshop Slidedeck](https://docs.google.com/presentation/d/1iM1ffdoy6otuBopqGTUTgnOC9nXgrzrcxN6l8xsF13Y/edit#slide=id.g23309be7886_1_55)
- [Gradual Modularity Office Hours Signup Sheet](https://forms.gle/cH9ShR8HFyQQA4B7A)

# Troubleshooting
## Gem xyz is not working for me, what do I do?
If we are unable to make things work without changing the gem, it’s highly encouraged to create a local fork of the gem by cloning the gem locally and updating your gemfile:
```ruby
gem 'gem_name', path: '../path/to/gem'
```

If others encounter the same issue, we encourage pushing the fork to GitHub and sharing in the slack server so folks can point to it:
```ruby
gem 'gem_name', github: 'username/gem_name', branch: 'main'
```

## Packwerk Check seems to be barfing on my codebase…?

Packwerk should spit out which file is having an issue. You can add that file to `excludes` in `packwerk.yml`. Please ask for help if you are still stuck!

## I’m getting `Error: error:0308010C:digital envelope routines::unsupported`

Try this: `export NODE_OPTIONS=--openssl-legacy-provider`
