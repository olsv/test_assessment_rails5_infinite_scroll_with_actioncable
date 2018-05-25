FactoryBot.define do
  factory :user do
    first_name { Randgen.first_name }
    last_name { Randgen.last_name }
    email { Randgen.email }
  end
end
