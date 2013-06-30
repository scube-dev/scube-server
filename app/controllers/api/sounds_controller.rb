class API::SoundsController < API::ApplicationController
  # FIXME: add some tests!
  def show
    sound = Sound.find params[:id]
    send_file sound.path, :type => sound.mime_type
  end
end
