class TracksController < ApplicationController
  def show
    @track = Track.find params[:id]
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(:name => params[:track][:name])
    if params[:track][:file]
      @track.uploaded_file = params[:track][:file]
    end
    if @track.save
      redirect_to @track
    else
      render :new
    end
  end

  def stream
  end
end
