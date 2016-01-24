scube-server
============

[![Build status][badge-build-img]][badge-build-uri]


Installation
------------

  scube-server requires ruby ~> 2.0 and PostgreSQL ~> 9.4. You will
need rubygems and the `bundler` gem installed. Check the `.travis.yml`
file for a list of rubies currently supported.

* Clone the repository
* Install the dependencies:
  ```
  bundle install
  ```
  [`bundle install` documentation](http://bundler.io/bundle_install.html)

* Configure the
  [database adapter](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/PostgreSQLAdapter.html):
  ```
  cp config/database.yml{.sample,}
  $EDITOR config/database.yml
  ```

* Create the database and executes the migrations:
  ```
  bundle exec rake db:create db:migrate db:test:prepare
  ```
  [Running Migrations Rails guide](http://edgeguides.rubyonrails.org/active_record_migrations.html#running-migrations)

* Configure
  [rails "secrets"](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml)
  by generating new keys. Using your own unique keys is preferred, but
  alternatively you can use the provided secrets sample configuration:
  ```
  cp config/secrets.yml{.sample,}
  ```

* Create directories used to store sound files:
  ```
  mkdir -p data/sounds data/test/sounds
  ```

  You can also check the `before_script` key in [Travis CI
configuration][travis-config-file] as the setup steps listed in this
key *must* be correct in order for tests to pass successfully on
Travis CI.

[travis-config-file]: https://raw.githubusercontent.com/scube-dev/scube-server/master/.travis.yml


Server start
------------

    rails server


Contributing
------------

* Make your changes in a new git branch from master
* Add tests for your changes
* Ensure all tests pass `rake RAILS_ENV=test`
* Make your changes available in a public repository
* Ask for review



[badge-build-uri]: https://travis-ci.org/scube-dev/scube-server
[badge-build-img]: https://img.shields.io/travis/scube-dev/scube-server/master.svg?style=flat-square
