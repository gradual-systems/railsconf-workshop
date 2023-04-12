# mastodon-workshop
Ruby At Scale Workshop with Mastodon

## Prerequisites

* We built this script for macos
* YOu must have [nvm](https://github.com/nvm-sh/nvm#install--update-script) and [rbenv](https://github.com/rbenv/rbenv#installation) installed

## Usage
Check out mastodon from the [gradual.systems fork of mastodon](https://github.com/gradual-systems/mastodon): https://github.com/gradual-systems/mastodon.

Check out this repo (the [mastodon-workshop](https://github.com/gradual-systems/mastodon-workshop)) next to the mastodon repo, like so:

```
tree . -L 1
.
├── mastodon
└── mastodon-workshop
```

### Setting up your machine to run mastodon

To install mastodon testing dependencies, run 

```
../mastodon-workshop/00_mastodon_test.sh
```

### Running the workshop code

There are more scripts in the repo, indexed 01, 02, and 03. We'll use these throughout the workshop.

### Running in non-interactive mode

You can run all scripts in NON-interactive mode like so:

```
export NI="y"
../mastodon-workshop/SCRIPT_YOU_WANT_TO_RUN
unset NI
```
