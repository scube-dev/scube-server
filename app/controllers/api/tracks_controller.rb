module API
  class TracksController < ApplicationController
    before_action :set_track, only: :show

    def index
      @tracks = Track.all
    end

    def show
    end

  private

    def set_track
      @track = Track.find(params[:id])
    end
  end
end
