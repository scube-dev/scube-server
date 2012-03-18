class Api::PlaylistsController < Api::ApplicationController
  respond_to :json

  def index
    @playlists = Playlist.all
  end
end
