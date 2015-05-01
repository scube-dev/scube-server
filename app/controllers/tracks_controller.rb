class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def edit
    @track = Track.find(params[:id])
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
    @track = Track.find(params[:id])

    if @track.update_attributes track_params
      redirect_to action: :index
    else
      render :edit
    end
  end


  private

  def track_params
    params.require(:track).permit %i[name file]
  end
end
