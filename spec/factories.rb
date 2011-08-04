FactoryGirl.define do
  factory :playlist do
    name 'Electro'
  end

  factory :track do
    name 'Mega song'
    mime_type 'audio/ogg'
    sha256 '94a5486a69a7261da350c57f9e5a1eaa789e08752cfc56a1989976a6ad82f7a8'
  end

  factory :user do
    email 'alice@example.net'
    password '733tP4s5'
  end
end
