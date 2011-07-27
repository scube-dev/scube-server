class HomeController < ApplicationController
  def index
    @playlists = Playlist.all
  end
end
