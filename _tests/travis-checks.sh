#!/bin/bash

set -e

# Execute Markdown Linter
mdl README.md _posts _pages --style _linter/markdown-linter-style.rb

# Github Pages needs the baseurl field to be "m-lab.github.io" to render properly in forked 
# repos, but when we deploy to production, we need the baseurl field to be empty. This 
# command replaces "m-lab.github.io" with an empty string.
sed -e '/^baseurl/s/\/m-lab\.github\.io//' _config.yml > _config-deploy.yml

# Run HTMLProofer
bundle exec jekyll build --config _config-deploy.yml
bundle exec htmlproofer ./_site --only-4xx --check-html --file-ignore "/mlab_observatory/","/ndt/" $1