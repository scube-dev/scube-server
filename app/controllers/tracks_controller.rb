class TracksController < ApplicationController
  before_filter :set_track, only: %i[show edit update]

  def index
    @tracks = Track.all
  end

  def show
  end

  def new
    @track = Track.new
  end

  def edit
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to @track
    else
      render :new
    end
  end

  def update
    if @track.update_attributes track_params
      redirect_to action: :index
    else
      render :edit
    end
  end


  private

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit %i[name file]
  end
end
