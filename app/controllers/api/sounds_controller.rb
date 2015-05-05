module API
  class SoundsController < ApplicationController
    skip_before_filter :json_filter!, only: :show

    before_action :set_sound, only: :show

    def show
      send_file @sound.path, type: @sound.mime_type
    end


    private

    def set_sound
      @sound = case params[:id]
        when /\A\d+\z/  then Sound.find(params[:id])
        when /\A\h+\z/  then Sound.find_by_sha256!(params[:id])
      end
    end
  end
end
