def build_sound_file
  File.new("#{Rails.root}/spec/fixtures/test.mp3").tap do |o|
    o.define_singleton_method(:content_type) { 'audio/mpeg' }
  end
end

FactoryGirl.define do
  factory :key do
    name 'Some key'
    user
  end

  factory :playlist do
    name 'Some playlist'
    user
  end

  factory :sound do
    file { build_sound_file }

    factory :sound_with_file_upload do
      file do
        sound_file = build_sound_file
        Rack::Test::UploadedFile.new(sound_file.path, sound_file.content_type)
      end
    end
  end

  factory :track do
    name 'Some track'

    factory :track_with_sound do
      file { build_sound_file }
    end
  end

  factory :user do
    sequence :email do |n|
      "bob_#{n}@example.net"
    end
    password '733tP4s5'
  end
end
