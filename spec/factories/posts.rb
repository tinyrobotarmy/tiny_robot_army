FactoryGirl.define do
  factory :post do
    subject { FFaker::Lorem.sentence }
    body { FFaker::Lorem.paragraph }
    author {|author| author.association(:user) }

    factory :pinned_post do
      pinned true
    end

    factory :published_post do
      status_id Status::PUBLISHED.id
    end
  end
end
