require "spec_helper"

class AdminUsingController < Admin::AdminController
  def test
    render text: 'you are an admin'
  end

  def current_user
    User.new(admin: false)
  end
end

def with_admin_routing
  with_routing do |map|
    map.draw do
      match '/test' => "admin_using#test"
    end
    yield
  end
end

describe AdminUsingController do
  before do
    Rails.application.routes.draw do
      match '/test' => "admin_using#test"
    end
    controller.stub(:current_user).and_return('ABC')
    #   controller.stub(:authenticate_user!).and_return true
  end

  after do
    Rails.application.reload_routes!
  end

  describe '#authenticate_admin! filter' do
    subject { get :test }
    let(:controller) { AdminUsingController.new }
    context 'when the urrent user is not an admin' do
      let(:user) { stub_model(User, :admin? => true) }
      
      it 'should send status 403' do
        # with_admin_routing do
          subject
          response.code.should == '403'
        # end
      end
    end
  end
end
