require 'spec_helper'

describe Book do

  it { should be_timestamped_document }

  it { should have_field(:title).of_type(String) }
  it { should validate_presence_of :title }

  # it { should embed_many :book_versions }
end
