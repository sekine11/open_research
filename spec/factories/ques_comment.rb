FactoryBot.define do
  factory :ques_comment do
    user_id { 1 }
    question_id { 1 }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
  end
end
