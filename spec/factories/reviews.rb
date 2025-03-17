FactoryBot.define do
  factory :review do
    content { "MyText" }
    user { nil }
    book { nil }
  end
end
