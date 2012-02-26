class Api::V0::PlaylistsController < ApplicationController
  respond_to :json

  def index
    @playlists = Playlist.all
    respond_with @playlists
  end
end
