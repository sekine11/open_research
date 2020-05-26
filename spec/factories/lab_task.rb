FactoryBot.define do
  factory :lab_task do
    user_id { 1 }
    laboratory_id { 1 }
    content { "テストテストテストテストテストテスト" }
  end
end
