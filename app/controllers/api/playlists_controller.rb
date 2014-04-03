module API
  class PlaylistsController < ApplicationController
    respond_to :json

    def index
      @playlists = Playlist.all
    end

    def create
      @playlist = current_user.playlists.build(playlist_params)
      @playlist.save
    end

    private

    def playlist_params
      params.require(:playlist).permit(:name)
    end
  end
end
