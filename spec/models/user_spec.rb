require 'spec_helper'

describe User do
  context '#normalize_email' do
    it 'strips whitespace' do
      user = FactoryGirl.create(:user, email: ' jeb@example.com ')
      user.email.should == 'jeb@example.com'
    end

    it 'downcases' do
      user = FactoryGirl.create(:user, email: 'JEB@example.com')
      user.email.should == 'jeb@example.com'
    end
  end

  context '#add_authorization' do
    let(:user) { FactoryGirl.create(:user) }

    it 'create an authorization' do
      expect {
        auth = user.add_authorization(build_auth_hash)
        auth.provider.should == 'developer'
        auth.uid.should == '49'
      }.to change(user.authorizations, :count).by(1)
    end
  end

  context '.create_from_authorization' do
    def create_from_authorization
      User.create_from_authorization(build_auth_hash)
    end

    it 'creates a user' do
      expect {
        user = create_from_authorization
        user.name.should == 'Jeb'
        user.email.should == 'jeb@example.com'
      }.to change(User, :count).by(1)
    end

    it 'creates an authorization' do
      expect {
        user = create_from_authorization
        auth = user.authorizations.first
        auth.provider.should == 'developer'
        auth.uid.should == '49'
      }.to change(Authorization, :count).by(1)
    end
  end
end
