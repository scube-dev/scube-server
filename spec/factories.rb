def build_sound_file
  File.new('spec/fixtures/test.mp3').tap do |o|
    o.define_singleton_method(:content_type) { 'audio/mpeg' }
  end
end

FactoryBot.define do
  factory :author do
    name 'Some author'
  end

  factory :key do
    name 'Some key'
    user
  end

  factory :playlist do
    name 'Some playlist'
    user
  end

  factory :release do
    name 'Some release'
    year 1982
  end

  factory :release_track do
    release
    track
    number 42
  end

  factory :sound do
    sha256    '1f68f4f8f965eeb55b1d9f4b8c9dccd772ecfeb54d37e801c81aeddea69dbebf'
    mime_type 'audio/mpeg'

    trait :with_file_upload do
      file do
        sound_file = build_sound_file
        Rack::Test::UploadedFile.new sound_file.path, sound_file.content_type
      end
    end
  end

  factory :track do
    name 'Some track'

    trait :with_file_upload do
      file do
        sound_file = build_sound_file
        Rack::Test::UploadedFile.new sound_file.path, sound_file.content_type
      end
    end
  end

  factory :user do
    sequence :email do |n|
      "bob_#{n}@example.net"
    end
    password '733tP4s5'
  end
end
