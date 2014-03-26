require 'spec_helper'

describe Book do

  subject { FactoryGirl.build :book, name: "Lemalar" }

  it "name is Lemalar" do
    expect(subject.name).to eq("Lemalar")
  end

  it "name is required" do
    subject.name = ""
    expect(subject).to_not be_valid
  end

  it "search books by name" do
    subject.save
    expect(described_class.search_by_name("lem")).to include(subject)
    expect(described_class.search_by_name("alar")).to include(subject)
  end

end
