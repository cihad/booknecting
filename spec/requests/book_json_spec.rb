require 'spec_helper'

describe "Book JSON" do

  let(:book) { FactoryGirl.create :book, name: "Example" }
  let(:user) { FactoryGirl.create :user }

  subject { book }

  before do
    book.users << user
    get book_path(subject, format: :json)
  end

  it "has id" do
    expect(JSON.parse(response.body)["id"]).to eq(subject.id)
  end

  it "has name" do
    expect(JSON.parse(response.body)["name"]).to eq("Example")
  end

  describe "image" do
    it "has original" do
      expect(JSON.parse(response.body)["image"]).to include("original")
    end

    it "has medium" do
      expect(JSON.parse(response.body)["image"]).to include("medium")
    end
  end

  describe "users" do
    it "should be a Array" do
      expect(JSON.parse(response.body)["users"]).to be_a(Array)  
    end

    it "has a user id" do
      expect(JSON.parse(response.body)["users"].first).to include("id")
    end

    it "has a user username" do
      expect(JSON.parse(response.body)["users"].first).to include("username")
    end

    it "has a user view name" do
      expect(JSON.parse(response.body)["users"].first).to include("view_name")
    end
  end

end