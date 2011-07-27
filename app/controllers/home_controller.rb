class HomeController < ApplicationController
  def index
    @playlists = Playlist.all
    @tracks = Track.latest
  end
end
