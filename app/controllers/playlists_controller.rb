class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = current_user.playlists.build(params[:playlist])
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
    if @playlist.update_attributes params[:playlist]
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end
end
