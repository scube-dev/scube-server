class SoundsController < ApplicationController
  skip_before_action :json_filter!, only: %i[show create]

  before_action :set_sound, only: :show

  def show
    send_file @sound.path, type: @sound.mime_type
  end

  def create
    @sound = Sound.new
    if SoundSaver.call(@sound, sound_params[:file])
      render :show, status: :created, location: sound_path(@sound)
    else
      render json: @sound.errors, status: :unprocessable_entity
    end
  end

private

  def set_sound
    @sound = case params[:id]
      when /\A\d+\z/  then Sound.find(params[:id])
      when /\A\h+\z/  then Sound.find_by_sha256!(params[:id])
    end
  end

  def sound_params
    params.require(:sound).permit :file
  end
end
