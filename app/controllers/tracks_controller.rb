class TracksController < ApplicationController
  def show
    @track = Track.find params[:id]
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(:name => params[:track][:name])
    if @track.save_with_file(
        params[:track][:file],
        params[:track][:file].content_type
      )
      redirect_to @track
    else
      render :new
    end
  end

  def download
    track = Track.find params[:id]
    send_file track.filepath, :type => track.mime_type
  end
end
