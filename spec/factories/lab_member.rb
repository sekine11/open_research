FactoryBot.define do
  factory :lab_member do
    user_id { 1 }
    laboratory_id { 1 }
    status { "admin" }

    trait :subadmin do
      status { "subadmin" }
    end
    trait :member do
      status { "member" }
    end

    factory :subadmin_member, traits: [:subadmin]
    factory :member_member, traits: [:member]
  end
end
