FactoryBot.define do
  factory :tip do
    title { FFaker::Lorem.sentence }
    anonym { FFaker::Boolean.sample }
    description { FFaker::Lorem.paragraph }
    experience { rand(0..5) }
    experience_extended { FFaker::Lorem.paragraph }
  end
end
