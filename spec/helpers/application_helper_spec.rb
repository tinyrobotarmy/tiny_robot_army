require 'spec_helper'

describe ApplicationHelper do
  before do
    helper.stub(:t).and_return 'xx'
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
