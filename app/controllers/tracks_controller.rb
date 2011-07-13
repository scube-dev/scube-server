class TracksController < ApplicationController
  def show
    @track = Track.find params[:id]
  end

  def stream
  end
end
