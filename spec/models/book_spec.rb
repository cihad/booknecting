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

  it "#amazon_asin" do
    expect(subject.amazon_asin).to be
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

    it "if text present" do
      search_text = double
      book_1 = double
      book_2 = double
      allow(described_class).to receive(:search_by_name).with(search_text).and_return([book_1])
      allow(AmazonBook).to receive(:search).with(search_text).and_return([book_2])
      expect(described_class.search(search_text)).to eq([book_1, book_2])
    end

    it "if doesnt text present" do
      books = double
      allow(described_class).to receive(:top).with(count: 10).and_return(books)
      expect(described_class.search()).to eq(books)
    end
  end

  it "#users" do
    users = double
    allow(subject).to receive(:liked_by).and_return(liked_by = double)
    allow(liked_by).to receive(:includes).with(:actor).and_return(includes = double)
    allow(includes).to receive(:where).with(actor_type: "User").and_return(where = double)
    allow(where).to receive(:map).and_return(users)

    expect(subject.users).to eq(users)
  end

  it "#tags" do
    tags = double
    allow(subject).to receive(:liked_by).and_return(liked_by = double)
    allow(liked_by).to receive(:includes).with(:actor).and_return(includes = double)
    allow(includes).to receive(:where).with(actor_type: "Tag").and_return(where = double)
    allow(where).to receive(:map).and_return(tags)
    
    expect(subject.tags).to eq(tags)
  end

  it "#tag_exists?" do
    tag = double
    allow(tag).to receive(:read?).with(subject).and_return(true)
    expect(subject.tag_exists?(tag)).to be_truthy
  end

  it "#add_tag" do
    tag = FactoryGirl.create :tag
    subject.save
    expect {
      subject.add_tag tag
    }.to change { subject.tags.count }.by(1)
  end

  it "#remove_tag" do
    tag = FactoryGirl.create :tag
    subject.save
    subject.add_tag tag
    expect {
      subject.remove_tag tag
    }.to change { subject.tags.count }.by(-1)
  end

  it "#amazon_book" do
    expect(subject).to_not be_amazon_book
  end

end
