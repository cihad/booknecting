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

  it ".search_by_name" do
    subject.save
    expect(described_class.search_by_name("lem")).to include(subject)
    expect(described_class.search_by_name("alar")).to include(subject)
  end

  it ".search_by_name ignoring accents options" do
    book = FactoryGirl.create :book, name: "Şualar"
    expect(described_class.search_by_name("sualar")).to include(book)
  end

  describe ".search" do

    it "if params exists" do
      books = double
      search_text = double
      allow(described_class).to receive(:search_by_name).with(search_text).and_return(books)
      expect(described_class.search(search_text)).to eq(books)
    end

    it "if doesnt params exist" do
      books = double
      expect(described_class.search()).to be_empty
    end
  end

  it "#users" do
    liked_by = double
    allow(subject).to receive(:liked_by).and_return(liked_by)

    expect(subject.users).to eq(liked_by)
  end

end
