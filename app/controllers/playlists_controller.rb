class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new params[:playlist]
    if @playlist.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
end
