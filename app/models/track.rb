class Track < ActiveRecord::Base
  validates_presence_of :name

  after_create :save_file

  def uploaded_file=(file)
    @file = file
  end

  def save_file
    if @file
      File.open("#{Rails.root}/data/tracks/#{id}", 'w') do |f|
        f.write @file.tempfile.read
      end
    end
  end
end
