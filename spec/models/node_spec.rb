require "spec_helper"

describe Node do

  let(:tag) { FactoryGirl.create :tag }
  subject { tag.node }
  let(:book) { FactoryGirl.create :book }

  it "#read changes to books count" do    
    expect {
      subject.read book
    }.to change { subject.read? book }.from(false).to(true)
  end
  
  describe "#unread" do

    before do
      subject.read book
    end

    it "decrements to books count" do
      expect {
        subject.unread book
      }.to change { subject.books.count }.by(-1)
    end
    
    it "changes to likes book" do
      expect {
        subject.unread book
      }.to change { subject.likes? book }.from(true).to(false)
    end
  end

  it "#read?" do
    subject.read book
    expect(subject.read? book).to be_truthy
  end

  it "#books" do
    allow(subject).to receive(:likes).and_return(likes = double)
    expect(subject.books).to eq(likes)
  end

end