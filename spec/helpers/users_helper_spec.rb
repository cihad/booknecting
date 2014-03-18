require 'spec_helper'

describe UsersHelper do

  it "#gravatar_for" do
    user = FactoryGirl.create :user
    expect(helper.gravatar_for(user)).to have_selector '.image'
  end

  it "#gravatar_url" do
    email = "cihadp@gmail.com"

    expect(helper.gravatar_url email).to \
      eq("http://www.gravatar.com/avatar/ed89ad8f70cf405fee4730948e813e89?s=80")
  end

end