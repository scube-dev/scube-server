class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update_attributes playlist_params
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
