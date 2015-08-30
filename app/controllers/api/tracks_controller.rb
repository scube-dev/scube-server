module API
  class TracksController < ApplicationController
    skip_before_action :json_filter!, only: %i[create]

    before_action :set_track, only: :show

    def index
      @tracks = Track.all
    end

    def show
    end

    def create
      @track = Track.new(track_params)
      if @track.save
        render :show, status: :created, location: api_track_path(@track)
      else
        render json: @track.errors, status: :unprocessable_entity
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
end
