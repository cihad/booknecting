require 'spec_helper'

describe "Book JSON" do

  let(:book) { FactoryGirl.create :book, name: "Example" }

  subject { book }

  before do
    get book_path(subject, format: :json)
  end

  it "has id" do
    expect(JSON.parse(response.body)["id"]).to eq(subject.id)
  end

  it "has name" do
    expect(JSON.parse(response.body)["name"]).to eq("Example")
  end

end