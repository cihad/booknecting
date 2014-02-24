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

end
