class API::PlaylistsController < API::ApplicationController
  respond_to :json

  def index
    @playlists = Playlist.all
  end

  def create
    @playlist = current_user.playlists.build(params[:playlist].slice(:name))
    @playlist.save
  end
end
