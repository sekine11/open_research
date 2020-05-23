FactoryBot.define do
  factory :protocol do
    user_id { 1 }
    subject { "テストテスト" }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
    protocol_list { ["テスト"] }
  end
end
