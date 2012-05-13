require 'spec_helper'
require 'storage_service'

describe StorageService do

  # Think about how to write these specs so that they aren't DropBox-specific

  it 'exists' do
    StorageService.new
  end

  it 'delegates to a storage implementation'
  it 'can authorize an account'
  it 'raises an error if the file does not exist'
  it 'raises an error if the session is not authorized'
  it 'can upload a file'
  it 'can return a private media URL'
  it 'can return a public media URL'
end
