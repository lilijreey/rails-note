require 'User'

describe User do
  it "is save" do
    expect (User.save?).to be_ture
  end
end
