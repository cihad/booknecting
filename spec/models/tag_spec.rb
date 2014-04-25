require 'spec_helper'

describe Tag do

  subject { FactoryGirl.build :tag, name: "Tag"  }

  it "has a name" do
    expect(subject.name).to eq("Tag")
  end

  it "name is required" do
    expect {
      subject.name = ""
      subject.save
    }.to_not change(Tag, :count)
  end

end