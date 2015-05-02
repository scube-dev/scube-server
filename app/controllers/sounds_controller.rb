class SoundsController < ApplicationController
  before_filter :set_sound, only: :show

  def show
    send_file @sound.path, type: @sound.mime_type
  end


  private

  def set_sound
    @sound = Sound.find(params[:id])
  end
end
