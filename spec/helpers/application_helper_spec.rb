require 'spec_helper'

describe ApplicationHelper do
  before do
    helper.stub(:t).and_return 'xx'
  end

  describe '#allow_comments' do
    it { should be_true }
  end

  describe "#message_box" do
    let(:content){ nil }
    subject{ helper.message_box(content) }
    it "should render a div with the class message-box" do
      subject.should have_selector('div', :class => 'message-box')
    end

    context "when a view has pushed up content_for the message box" do
      let(:content){ 'content from a view' }

      it "should render the content inside the message box" do
        subject.should have_selector('div', :class => 'message-box', :content => 'content from a view')
      end
    end

    context "when there is a flash error message" do
      before do
        flash[:alert] = 'You screwed up!'
      end

      it "should render the error message inside a div with the class alert" do
        subject.should have_selector('div.message-box>div', :class => 'alert', :content => 'You screwed up!')
      end
    end

    context "when there is a flash notice message" do
      before do
        flash[:notice] = 'You screwed did good!'
      end

      it "should render the message inside a div with the class notice" do
        subject.should have_selector('div.message-box>div', :class => 'notice', :content => 'You screwed did good!')
      end
    end

    context "when a view has pushed up content and there is a flash error message" do
      let(:content){ 'content from a view' }
      before do
        flash[:alert] = 'You screwed up!'
      end

      it "should render the view content inside the message box" do
        subject.should have_selector('div', :class => 'message-box', :content => 'content from a view')
      end
    end
  end

  describe '#admin_link' do
    subject { helper.admin_link user }
    context 'when the user is nil' do
      let(:user) { nil }
      it { should be_nil }
    end
    context 'when the user is a normal user' do
      let(:user) { User.new }
      it { should be_nil }
    end
    context 'when the user is an admin' do
      let(:user) { User.new(admin: true) }
      it 'should render a link to the admin dashboard' do
        subject.should have_selector(:a, href: admin_dashboard_path)
      end
    end

  end

  describe '#sign_in_out' do
    subject { helper.sign_in_out user }
    context 'when the user is nil' do
      let(:user) { nil }
      it 'should render a link to sign in' do
        subject.should have_selector(:a, href: new_user_session_path)
      end
    end
    context 'when the user present' do
      let!(:user) { User.new }
      it 'should render a link to sign out' do
        subject.should have_selector(:a, href: destroy_user_session_path(user))
      end
    end

  end
end
