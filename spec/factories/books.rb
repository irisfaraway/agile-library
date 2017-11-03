FactoryBot.define do
  # Sequences
  sequence(:title) { |n| "Book #{n}" }

  factory :book do
    title { generate(:title) }
    author 'Author Name'

    # Traits
    trait :is_available do
      status 1
    end

    trait :is_on_loan do
      status 2
    end
  end
end
