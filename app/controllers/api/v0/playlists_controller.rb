class Api::V0::PlaylistsController < Api::ApplicationController
  respond_to :json

  def index
    @playlists = Playlist.all
    respond_with @playlists
  end
end
