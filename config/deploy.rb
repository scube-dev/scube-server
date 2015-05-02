require 'producer/rails'

set :repository,  'git:scube/scube-server'
set :app_path,    'www/scube-server'
set :app_mkdir,   %w[data/sounds]

deploy
