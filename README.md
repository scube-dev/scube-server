scube-server
============


Installation
------------

  You'll need ruby, rubygems and the bundler gem installed.

  Check `rvm` key in `.travis.yml` configuration for supported rubies.

* Clone the repository
* Install dependencies:
    ```
    bundle install
    ```

* Configure the database adapter:
    ```
    cp config/database.yml{.sample,}
    $EDITOR config/database.yml
    ```

* Create and migrate the databases:
    ```
    bundle exec rake db:create db:migrate db:test:prepare
    ```

* Configure rails "secrets"
  http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml


Start
-----

    rails server


Contributing
------------

* Make your changes in a new git branch from master
* Add tests for your changes
* Ensure all tests pass `rake RAILS_ENV=test`
* Make your changes available in a public repository
* Ask for review
