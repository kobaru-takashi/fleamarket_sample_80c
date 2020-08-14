FactoryBot.define do

  factory :user do
    nickname              {Faker::JapaneseMedia::OnePiece.character}
    email                 {Faker::Internet.email}
    password              {"000aaaa"}
    password_confirmation {"000aaaa"}
    family_name           {"阿部尾"}
    first_name            {"ジミー"}
    family_name_kana      {"アベオ"}
    first_name_kana       {"ジミー"}
    birth_date            {"2010-10-12"}
  end

end