module API
  class SoundsController < ApplicationController
    skip_before_filter :json_filter!, only: :show

    before_action :set_sound, only: :show

    def show
      send_file @sound.path, type: @sound.mime_type
    end


    private

    def set_sound
      @sound = Sound.find(params[:id])
    end
  end
end
