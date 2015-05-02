class PlaylistsController < ApplicationController
  before_filter :set_playlist, only: %i[edit update]

  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = current_user.playlists.build playlist_params

    if @playlist.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @playlist.update_attributes playlist_params
      redirect_to action: :index
    else
      render :edit
    end
  end


  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit :name
  end
end
