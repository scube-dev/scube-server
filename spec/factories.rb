def build_sound_file
  File.new("#{Rails.root}/spec/fixtures/test.mp3").tap do |o|
    o.define_singleton_method(:content_type) { 'audio/mpeg' }
  end
end

FactoryGirl.define do
  factory :playlist do
    name 'Electro'
    user
  end

  factory :sound do
    file { build_sound_file }
  end

  factory :track do
    name 'Mega song'

    factory :track_with_sound do
      file { build_sound_file }
    end
  end

  factory :user do
    sequence :email do |n|
      "alice_#{n}@example.net"
    end
    password '733tP4s5'
  end
end
