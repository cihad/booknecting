require 'spec_helper'

describe User do
  subject do
    FactoryGirl.build :user,
                      username: "cihad",
                      name: "Cihad Paksoy"
  end

  it_behaves_like "Readable"

  it { should be_valid }

  it "if valid, increments total User count" do
    expect {
      subject.save
    }.to change(User, :count).by(1)
  end

  it "#name" do
    expect(subject.name).to be
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

  it "#similar_users" do
    allow(subject).to receive_message_chain(:similar_raters, :select).and_return(similar_users = double)
    allow(subject).to receive(:similar_users).and_return(similar_users) 
  end

end
