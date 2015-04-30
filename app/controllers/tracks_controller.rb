class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to @track
    else
      render :new
    end
  end

  private

  def track_params
    params.require(:track).permit %i[name file]
  end
end
