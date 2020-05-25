FactoryBot.define do
  factory :discussion do
    user_id { 1 }
    subject { "テストテスト" }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
    discussion_list { ["DNA"] }
  end
end
