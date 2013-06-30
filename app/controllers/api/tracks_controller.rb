class API::TracksController < API::ApplicationController
  def index
    @tracks = Track.all
  end
end
