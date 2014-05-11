require 'spec_helper'

describe Tag do
  it_behaves_like "Readable"

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

  it "name is uniquenes" do
    subject.save
    expect {
      new_tag = FactoryGirl.build :tag, name: "tag"
      new_tag.save
    }.to_not change(Tag, :count)
  end

  it "#format_name" do
    subject.name = "Ali Ata Bak"
    expect {
      subject.save
    }.to change { subject.name }.from("Ali Ata Bak").to("ali ata bak")
  end

  it "#similar_users" do
    similar_users = double 
    allow(subject).to receive_message_chain(:similar_raters, :select).and_return(similar_users)

    expect(subject.similar_users).to eq(similar_users)
  end

end