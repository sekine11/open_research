FactoryBot.define do
  factory :lab_information do
    user_id { 1 }
    laboratory_id { 1 }
    subject { "テストテスト" }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
  end
end
