require 'spec_helper'

describe Authorization do
  context '.build_from_authorization' do
    let(:built_auth) { Authorization.build_from_authorization(build_auth_hash) }

    it 'builds an authorization' do
      built_auth.should_not be_nil
      built_auth.should be_new_record
    end

    it 'ignores extra params' do
      built_auth.should_not respond_to(:trunk)
      built_auth.should_not respond_to(:info)
    end
  end

  context '.find_by_authorization' do
    let(:auth) { FactoryGirl.create(:authorization) }

    it 'finds an authorization by provider and uid' do
      Authorization.find_by_authorization(build_auth_hash(auth.provider, auth.uid)).should == auth
    end

    it 'returns nil if the authorization does not exist' do
      Authorization.find_by_authorization(
        'provider'  => 'grillebook',
        'uid'       => '31337'
      ).should be_nil
    end
  end
end
