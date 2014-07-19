FactoryGirl.define do
  factory :post do
    subject { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    author {|author| author.association(:user) }
    factory :pinned_post do
      pinned true
    end
  end
end
