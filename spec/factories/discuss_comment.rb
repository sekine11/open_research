FactoryBot.define do
  factory :discuss_comment do
    user_id { 1 }
    discussion_id { 1 }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
  end
end
