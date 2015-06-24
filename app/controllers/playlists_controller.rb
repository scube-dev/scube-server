class PlaylistsController < ApplicationController
  include Dry::Controller

  dry_scope       { current_user.playlists }
  dry_attrs_read  :name
  dry_attrs_write :name
end
