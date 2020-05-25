FactoryBot.define do
  factory :question do
    user_id { 1 }
    subject { "テストテスト" }
    content { "テストテストテストテストテストテストテストテストテストテスト" }
    question_list { ["DNA"] }
  end
end
