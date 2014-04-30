require 'spec_helper'

describe User do

  subject do
    FactoryGirl.build :user,
                      username: "cihad",
                      name: "Cihad Paksoy"
  end

  it { should be_valid }

  it "if valid, increments total User count" do
    expect {
      subject.save
    }.to change(User, :count).by(1)
  end

  describe "#view_name" do
    it "name when it is" do
      expect(subject.view_name).to eq("Cihad Paksoy")
    end

    it "name when it is not" do
      subject.name = nil
      expect(subject.view_name).to eq("cihad")
    end
  end

  describe "username" do
    it "is required" do
      subject.username = ""
      expect(subject).to_not be_valid
      expect(subject.errors.messages[:username]).to be_include \
        I18n.t('activerecord.errors.messages.blank')
    end

    it "is uniqueness" do
      subject.save
      other_user = FactoryGirl.build(:user, username: "cihad")
      other_user.valid?
      expect(other_user.errors.messages).to be_include(:username)
      expect(other_user.errors.messages[:username]).to be_include \
        I18n.t('activerecord.errors.messages.taken')
    end

    it "is uniq case sensivite" do
      subject.save
      other_user = FactoryGirl.build(:user, username: "Cihad")
      other_user.valid?
      expect(other_user.errors.messages).to be_include(:username)
      expect(other_user.errors.messages[:username]).to be_include \
        I18n.t('activerecord.errors.messages.taken')
    end
  end

  it "#name" do
    expect(subject.name).to be
  end

  it "#read changes to books count" do
    book = FactoryGirl.create :book
    subject.save
    
    expect {
      subject.read book
    }.to change { subject.read? book }.from(false).to(true)
  end
  

  describe "#unread" do
    let(:book) { FactoryGirl.create :book }

    before do
      subject.save
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
    book = FactoryGirl.create :book
    subject.save
    subject.read book
    expect(subject.read? book).to be_truthy
  end

  it "#books" do
    allow(subject).to receive(:likes).and_return(likes = double)
    expect(subject.books).to eq(likes)
  end

end
