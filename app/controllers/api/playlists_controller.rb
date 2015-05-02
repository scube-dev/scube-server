module API
  class PlaylistsController < ApplicationController
    before_action :set_playlist, only: :show

    def index
      @playlists = Playlist.all
    end

    def show
    end

    def create
      @playlist = current_user.playlists.build playlist_params
      @playlist.save
    end


    private

    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params.require(:playlist).permit :name
    end
  end
end
