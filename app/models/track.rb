class Track < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :mime_type
  validates_presence_of :sha256

  def filepath
   "#{Rails.root}/data/tracks/#{sha256}"
  end

  def save_with_file(file, mime_type)
    self.sha256 = Digest::SHA256.file(file.path).hexdigest
    self.mime_type = mime_type
    File.open(filepath, 'w') do |f|
      f.write file.read
    end
    save!
  end

  def self.latest
    Track.order('created_at DESC')
  end
end
