require "spec_helper"

describe AmazonBook do

  let(:item) do
    item = double()
    allow(item).to receive(:get).with('ASIN').and_return("CB124Q2348")
    allow(item).to receive(:get).with('ItemAttributes/Title').and_return("The Book Name")
    allow(item).to receive(:get_hash).with('LargeImage').and_return({"URL" => "http://example.org/image.jpg"})
    item
  end

  subject { described_class.new(item) }

  it "#id" do
    expect(subject.id).to eq("CB124Q2348")
  end

  it "#amazon_book?" do
    expect(subject).to be_amazon_book
  end

  it "#to_key" do
    expect(subject.to_key).to eq(["CB124Q2348"])
  end

  it "#to_param" do
    expect(subject.to_param).to eq("ASINCB124Q2348")
  end

  it "#name" do
    expect(subject.name).to eq("The Book Name")
  end

  it "#image" do
    image = double
    allow(AmazonImage).to receive(:new).with(item).and_return(image)
    expect(subject.image).to eq(image)
  end

  it "#image?" do
    allow(subject).to receive(:image).and_return(double)
    expect(subject).to be_image
  end

  it "#asin" do
    expect(subject.asin).to eq("CB124Q2348")
  end

  it "#to_partial_path" do
    expect(subject.to_partial_path).to eq("books/book")
  end

  it "#users" do
    expect(subject.users).to be_empty
  end

  it "#tags" do
    expect(subject.tags).to be_empty
  end

  it "#tag_exists?" do
    expect(subject.tag_exists?("tag")).to eq(false)
  end

  it "#add_tag" do
    expect(subject.add_tag("tag")).to eq(false)
  end

  it "#remove_tag" do
    expect(subject.remove_tag("tag")).to eq(false)
  end

  it ".find" do
    items = double items: [item]
    allow(Amazon::Ecs).to receive(:item_lookup).with("CB124Q2348", { response_group: "Medium" }).and_return(items)
    expect(described_class.find("ASINCB124Q2348").asin).to eq("CB124Q2348")
  end


  describe ".search" do
    it "when it raises SocketError" do
      allow(Amazon::Ecs).to receive(:item_search).with(any_args()).and_raise(SocketError)
      expect(described_class.search("The Book Name")).to eq([])
    end

    it "when it doesnt raise any error" do
      items = double items: [item]
      amazon_book = double asin: "CB124Q2348"
      allow(described_class).to receive(:new).with(item).and_return(amazon_book)
      allow(Book).to receive(:exists?).with(amazon_asin: "CB124Q2348").and_return(false)
      allow(Amazon::Ecs).to receive(:item_search).with("The Book Name", { response_group: 'Medium'}).and_return(items)
      expect(described_class.search("The Book Name")).to eq([amazon_book])
    end
  end

  it "#persist_from_amazon!" do
    expect {
      subject.persist_from_amazon!
    }.to change(Book, :count).by(1)
  end

  it "#unless_asin_prefix" do
    expect(described_class.unless_asin_prefix("ASIN12345678")).to eq("12345678")
    expect(described_class.unless_asin_prefix("12345678")).to eq("12345678")
  end

  describe ::AmazonImage do
    it "#medium" do
      expect(AmazonImage.new(item).medium.url).to eq("http://example.org/image.jpg")
    end
  end

end