FactoryBot.define do
  factory :user do
    private_name { "テスト" }
    public_name { "テスト太郎" }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end