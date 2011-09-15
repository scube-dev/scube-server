FactoryGirl.define do
  factory :playlist do
    name 'Electro'
    user
  end

  factory :track do
    name 'Mega song'
    mime_type 'audio/ogg'
    sha256 '94a5486a69a7261da350c57f9e5a1eaa789e08752cfc56a1989976a6ad82f7a8'

    after_create do |t|
      t.save_with_file(File.new("#{Rails.root}/spec/fixtures/test.mp3"), 'audio/mpeg')
    end
  end

  factory :user do
    sequence :email do |n|
      "alice_#{n}@example.net"
    end
    password '733tP4s5'
  end
end
