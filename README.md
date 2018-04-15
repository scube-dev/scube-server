scube-server
============


Installation
------------

  scube-server requires Ruby and PostgreSQL ~> 9.4. You will need
rubygems and the `bundler` gem installed. Check the `.travis.yml` file
for a list of rubies currently supported.

* Clone the repository
* Install the dependencies:
  ``` shell
  bundle install
  ```
* Configure the [database adapter][rails-ar-config]:
  ``` shell
  cp config/database.yml{.sample,}
  $EDITOR config/database.yml
  ```
* Create the database and tables:
  ``` shell
  bundle exec rake db:create db:schema:load db:seed
  ```
* Configure [rails "secrets"][rails-secrets] by generating new keys.
  Using your own unique keys is preferred, but you can also use the
  provided secrets sample configuration:
  ``` shell
  cp config/secrets.yml{.sample,}
  ```
* Create directories for sound files storage:
  ``` shell
  mkdir -p data/sounds data/test/sounds
  ```


Server start
------------

``` shell
rails server
```


Contributing
------------

* Make your changes in a new git branch from master;
* Ensure all tests pass (`rake`);
* Make your changes available in a public repository;
* Ask for review.



[rails-ar-config]: http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/PostgreSQLAdapter.html
[rails-secrets]: http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml
