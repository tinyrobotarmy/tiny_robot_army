require "spec_helper"

describe Post do
  it { should validate_presence_of :subject }
  it { should validate_presence_of :body }

  it { should belong_to :author }

  it { should have_many :comments }

  describe 'creation' do
    it 'should set a status of DRAFT if not status is provided' do
      Post.create(subject: 'sub', body: 'bod').status.should == Status::DRAFT
    end

    it 'should not override the status if it is provided' do
      Post.create(subject: 'sub', body: 'bod', status_id: Status::PUBLISHED.id).status.should == Status::PUBLISHED
    end
  end

  describe '#body' do
    let(:post) { Post.new }
    it 'should reject script blocks' do
      post.body = '<script>Naughty script</script>Some other text'
      post.body.should == 'Some other text'
    end
  end
end
