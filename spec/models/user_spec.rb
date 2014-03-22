require 'spec_helper'

describe User do

  subject do
    FactoryGirl.build :user,
                      username: "cihad",
                      first_name: "Cihad",
                      last_name: "Paksoy"
  end

  it { should be_valid }

  it "if valid, increments total User count" do
    expect {
      subject.save
    }.to change(User, :count).by(1)
  end

  describe "#view_name" do
    it "first name and last name when it is" do
      expect(subject.view_name).to eq("Cihad Paksoy")
    end

    it "first name and last name when it is not" do
      subject.first_name = nil
      subject.last_name = nil
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

  it "#first_name" do
    subject.first_name
  end

  it "#last_name" do
    subject.last_name
  end

  it "#name" do
    subject.first_name = "Cihad"
    subject.last_name = "Paksoy"
    expect(subject.name).to eq("Cihad Paksoy")
  end
end
