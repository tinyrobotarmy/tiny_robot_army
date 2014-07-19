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

  describe '#status=' do
    subject { post.status = status }
    let(:post) { Post.new }

    context 'when the status is nil' do
      let(:status) { nil }
      it 'should set the status on the post to nil' do
        subject
        expect(post.status).to be_nil
      end
    end

    context 'when the status is nil' do
      let(:status) { Status::PUBLISHED }
      it 'should set the status on the post' do
        subject
        expect(post.status).to eql Status::PUBLISHED
      end
    end
  end
end
