require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    let(:auth_hash) { build_auth_hash }
    let(:existing_user) { FactoryGirl.create(:user) }
    let(:sign_in_user!) {
      session[:user_id] = existing_user.id
      existing_user
    }
    let(:create_session!) {
      request.env['omniauth.auth'] = auth_hash
      get :create, provider: 'development'
    }

    context 'with a logged in user' do
      before {
        sign_in_user!
        create_session!
      }

      it 'adds an authorization to the user' do
        existing_user.authorizations.size.should == 2
        a = existing_user.authorizations.last
        a.provider.should == 'developer'
        a.uid.should == '49'
      end

      it 'redirects to the root' do
        response.should redirect_to root_path
      end
    end

    context 'with an existing user' do
      let(:auth_hash) {
        auth = existing_user.authorizations.first
        build_auth_hash(auth.provider, auth.uid)
      }
      before {
        existing_user
        create_session!
      }

      it 'sets the current user' do
        controller.send(:current_user).should == existing_user
      end

      it 'redirects to the root' do
        response.should redirect_to root_path
      end
    end

    context 'with no existing user' do
      before {
        expect {
          create_session!
        }.to change(User, :count).by(1)
      }

      it 'sets the current user' do
        controller.send(:current_user).should == User.last
      end

      it 'redirects to the root' do
        response.should redirect_to root_path
      end

      it "creates a new user with the authentication details" do
        u = User.last
        u.name.should == 'Jeb'
        u.email.should == 'jeb@example.com'
        u.authorizations.size.should == 1

        a = u.authorizations.first
        a.provider.should == 'developer'
        a.uid.should == '49'
      end
    end
  end

  describe "GET 'failure'" do
    it "returns http success" do
      get 'failure'
      response.should be_success
    end
  end

end
