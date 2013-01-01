require "spec_helper"

describe Post do
  it { should validate_presence_of :subject }
  it { should validate_presence_of :body }

  it { should belong_to :author }

  it { should have_many :comments }

  describe '#body' do
    let(:post) { Post.new }
    it 'should reject script blocks' do
      post.body = '<script>Naughty script</script>Some other text'
      post.body.should == 'Some other text'
    end
  end
end