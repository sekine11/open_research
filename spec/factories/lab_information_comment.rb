FactoryBot.define do
  factory :lab_information_comment do
    user_id { 1 }
    lab_information_id { 1 }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
  end
end
