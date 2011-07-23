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
        params[:track][:file].tempfile,
        params[:track][:file].content_type
      )
      redirect_to @track
    else
      render :new
    end
  end

  def stream
    track = Track.find params[:id]
    self.content_type = track.mime_type
    self.response_body = Streamer.new(track.filepath)
  end
end
