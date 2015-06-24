class KeysController < ApplicationController
  include Dry::Controller

  dry_scope       { current_user.keys }
  dry_attrs_write :name
end
