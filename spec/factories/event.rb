FactoryBot.define do
  factory :event do
    user_id { 1 }
    laboratory_id { 1 }
    title { "テストテストテストテストテストテスト" }
    start { Time.now }
    sequence(:end) { Time.now }
  end
end
