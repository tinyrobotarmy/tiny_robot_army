FactoryGirl.define do
    factory :comment do
        body { FFaker::Lorem.paragraph }
        author {|author| author.association(:user) }
        post {|post| post.association(:post) }
    end
end