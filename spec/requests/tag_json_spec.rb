require 'spec_helper'

describe "Tag JSON" do

  let(:tag) { FactoryGirl.create :tag, name: "Example" }
  subject { tag }

  before do
    get tag_path(subject, format: :json)
  end

  it "has id" do
    expect(JSON.parse(response.body)["id"]).to eq(subject.id)
  end

  it "has name" do
    expect(JSON.parse(response.body)["name"]).to eq("Example")
  end

end