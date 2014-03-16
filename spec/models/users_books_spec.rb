require "spec_helper"

describe "Users Books" do

  let(:user) { FactoryGirl.create :user }
  let(:book) { FactoryGirl.create :book }

  it "adds book to user books" do
    expect {
      user.books << book
    }.to change { user.books.count }.by(1)
  end

end