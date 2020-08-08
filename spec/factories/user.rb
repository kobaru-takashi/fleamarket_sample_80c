FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"abeo"}
    first_name            {"jimmy"}
    family_name_kana      {"アベオ"}
    first_name_kana       {"ジミー"}
    birth_date            {"2010-10-12"}
  end

end