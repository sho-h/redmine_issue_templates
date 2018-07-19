#!/bin/sh

echo "target redmine version: ${REDMINE_VER}"
echo "target branch: ${TRAVIS_BRANCH}"
git clone --depth=1 --branch=${REDMINE_VER} https://github.com/redmine/redmine.git
cp /database.yml /redmine/config/
git clone --depth=1 --branch=${TRAVIS_BRANCH} https://github.com/akiko-pusu/redmine_issue_templates.git /redmine/plugins/redmine_issue_templates
mv /redmine/plugins/redmine_issue_templates/Gemfile.local /redmine/plugins/redmine_issue_templates/Gemfile
cd /redmine
bundle install --without rmagick
bundle exec rake db:migrate
bundle exec rake redmine:plugins:migrate
bundle exec rake redmine:plugins:test
