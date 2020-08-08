FactoryBot.define do

  factory :address do

    family_name           {"阿部尾"}
    first_name            {"ジミー"}
    family_name_kana      {"アベオ"}
    first_name_kana       {"ジミー"}
    post_code             {"123-4567"}
    prefecture            {3}
    city                  {"横浜市"}
    address               {"新町1-1"}
    building              {"パークハイツ"}
    telephone_number      {"09012345678"}
  end

end