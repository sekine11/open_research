FactoryBot.define do
  factory :user do
    private_name { "テスト太郎" }
    public_name { "太郎" }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end