require 'spec_helper'

describe Category do
  specify 'name should not be null.' do
    category = Category.new

    expect(category).not_to be_valid
    expect(category.errors[:name]).to be_present
  end
end