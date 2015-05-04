module API
  class PlaylistsController < ApplicationController
    before_action :set_playlist, only: %i[show update destroy]

    def index
      @playlists = Playlist.all
    end

    def show
    end

    def create
      @playlist = current_user.playlists.build playlist_params
      if @playlist.save
        render :show, status: :created
      else
        render json: @playlist.errors, status: :unprocessable_entity
      end
    end

    def update
      @playlist.update playlist_params
      head :no_content
    end

    def destroy
      @playlist.destroy
      head :no_content
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
