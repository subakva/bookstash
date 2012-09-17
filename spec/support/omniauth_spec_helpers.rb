module OmniAuthSpecHelpers
  def build_auth_hash(provider = nil, uid = nil)
    {
      'provider'  => provider || 'developer',
      'uid'       => uid || '49',
      'trunk' => 'junk',
      'extra' => { 'special' => 'friend' },
      'info'      => {
        'name'  => 'Jeb',
        'email' => 'jeb@example.com'
      }
    }
  end
end

RSpec.configure do |config|
  config.include OmniAuthSpecHelpers
end
