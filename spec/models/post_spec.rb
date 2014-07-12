require "rails_helper"

describe Post, :type => :model do
  it { is_expected.to validate_presence_of :subject }
  it { is_expected.to validate_presence_of :body }

  it { is_expected.to belong_to :author }

  it { is_expected.to have_many :comments }

  describe 'creation' do
    it 'should set a status of DRAFT if not status is provided' do
      expect(Post.create(subject: 'sub', body: 'bod').status).to eq(Status::DRAFT)
    end

    it 'should not override the status if it is provided' do
      expect(Post.create(subject: 'sub', body: 'bod', status_id: Status::PUBLISHED.id).status).to eq(Status::PUBLISHED)
    end
  end

  describe '#body' do
    let(:post) { Post.new }
    it 'should reject script blocks' do
      post.body = '<script>Naughty script</script>Some other text'
      expect(post.body).to eq('Some other text')
    end
  end
end
