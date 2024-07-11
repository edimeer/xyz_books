require 'rails_helper'

RSpec.describe Publisher, type: :model do
  it "is valid with valid attributes" do
    publisher = Publisher.new(name: 'Test Publisher')
    expect(publisher).to be_valid
  end

  it "is not valid without a name" do
    publisher = Publisher.new(name: nil)
    expect(publisher).not_to be_valid
  end
end
