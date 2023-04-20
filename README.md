# railsconf-workshop
Ruby At Scale Workshop with Mastodon

## Prerequisites

* We built this script for macos

## Before the workshop

### Setting up your machine to run mastodon

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

## During the workshop

### Running the workshop code

There are more scripts in the repo, indexed 01, 02, and 03. We'll use these throughout the workshop.

